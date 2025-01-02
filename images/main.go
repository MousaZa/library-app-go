package main

import (
	"context"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/MousaZa/library-app-go/images/server"
	"github.com/gin-gonic/gin"
	"github.com/hashicorp/go-hclog"
)

func main() {
	l := hclog.Default()

	router := gin.Default()

	server.SetupRoutes(router)

	s := http.Server{
		Addr:    ":9292",
		Handler: router,
	}

	go func() {
		l.Info("Starting server on port 9292")
		err := s.ListenAndServe()
		if err != nil {
			l.Error("Unable to start server", "error", err)
		}
	}()

	sigChan := make(chan os.Signal)
	signal.Notify(sigChan, os.Interrupt)
	signal.Notify(sigChan, os.Kill)

	sig := <-sigChan
	l.Info("Received terminate, graceful shutdown", sig)
	tc, _ := context.WithTimeout(context.Background(), 30*time.Second)
	s.Shutdown(tc)
}

package main

import (
	"context"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/MousaZa/library-app-go/books/handlers"
	"github.com/gorilla/mux"
	"github.com/hashicorp/go-hclog"
)

func main() {
	l := hclog.Default()

	bh := handlers.NewBooksHandler(l)

	r := mux.NewRouter()

	r.HandleFunc("/books", bh.GetBooks).Methods("GET")

	s := http.Server{
		Addr:    ":9090",
		Handler: r,
	}

	go func() {
		l.Info("Starting server on port 9090")
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

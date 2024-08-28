package main

import (
	"context"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/MousaZa/library-app-go/books/handlers"
	"github.com/MousaZa/library-app-go/books/models"
	"github.com/MousaZa/library-app-go/books/storage"
	"github.com/gorilla/mux"
	"github.com/hashicorp/go-hclog"
	"github.com/joho/godotenv"
)

func main() {
	l := hclog.Default()

	err := godotenv.Load(".env")
	if err != nil {
		l.Error("Unable to get env", "error", err)
	}

	config := &storage.Config{
		Host:     os.Getenv("DB_HOST"),
		Port:     os.Getenv("DB_PORT"),
		User:     os.Getenv("DB_USER"),
		Password: os.Getenv("DB_PASS"),
		DBName:   os.Getenv("DB_NAME"),
		SSLMode:  os.Getenv("DB_SSLMODE"),
	}

	db, err := storage.NewConnection(config)

	if err != nil {
		l.Error("Unable to connect to database", "error", err)
	}

	err = models.MigrateBooks(db)

	if err != nil {
		l.Error("Unable to migrate books", "error", err)
	}

	r := handlers.Repository{
		DB: db,
	}

	router := mux.NewRouter()

	r.SetupRoutes(router)

	s := http.Server{
		Addr:    ":9090",
		Handler: router,
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

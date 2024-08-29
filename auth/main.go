package main

import (
	"log"
	"os"

	"github.com/MousaZa/library-app-go/auth/models"
	"github.com/MousaZa/library-app-go/auth/server"
	"github.com/MousaZa/library-app-go/auth/storage"
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

	err = models.MigrateUsers(db)

	if err != nil {
		l.Error("Unable to migrate books", "error", err)
	}
	if _, err := server.NewServer(":8080", db); err != nil {
		log.Fatal("Failed to start server\n")
	}
}

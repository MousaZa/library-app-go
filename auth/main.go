package main

import (
	"log"
	"os"

	"github.com/MousaZa/library-app-go/auth/clients"
	"github.com/MousaZa/library-app-go/auth/models"
	"github.com/MousaZa/library-app-go/auth/server"
	"github.com/MousaZa/library-app-go/auth/storage"
	"github.com/MousaZa/library-app-go/borrows/protos/borrows"
	"github.com/hashicorp/go-hclog"
	"github.com/joho/godotenv"
	"google.golang.org/grpc"
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

	// Borrows client
	conn, err := grpc.NewClient("localhost:9092", grpc.WithInsecure())
	if err != nil {
		panic(err)
	}

	defer conn.Close()

	// create client
	borrowsClient := borrows.NewBorrowsClient(conn)

	bc := clients.NewBorrowsClient(borrowsClient)

	if _, err := server.NewServer(":8080", db, bc); err != nil {
		log.Fatal("Failed to start server\n")
	}
}

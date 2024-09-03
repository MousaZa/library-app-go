package main

import (
	"net"
	"os"

	"github.com/MousaZa/library-app-go/borrows/models"
	protos "github.com/MousaZa/library-app-go/borrows/protos/borrows"
	"github.com/MousaZa/library-app-go/borrows/server"
	"github.com/MousaZa/library-app-go/borrows/storage"
	"github.com/hashicorp/go-hclog"
	"github.com/joho/godotenv"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

func main() {
	log := hclog.Default()

	log.Info("Starting borrows server" + os.Getenv("DB_HOST"))

	err := godotenv.Load(".env")
	if err != nil {
		log.Error("Unable to get env", "error", err)
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
		log.Error("Unable to connect to database", "error", err)
		os.Exit(1)
	}

	err = models.MigrateBorrows(db)

	if err != nil {
		log.Error("Unable to migrate borrows", "error", err)
		os.Exit(1)
	}

	gs := grpc.NewServer()
	cs := server.NewBorrowsServer(log, db)

	protos.RegisterBorrowsServer(gs, cs)

	reflection.Register(gs)

	l, err := net.Listen("tcp", ":9092")
	if err != nil {
		log.Error("unable to listen", err)
		os.Exit(1)
	}

	gs.Serve(l)
}

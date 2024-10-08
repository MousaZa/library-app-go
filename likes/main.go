package main

import (
	"net"
	"os"

	"github.com/MousaZa/library-app-go/likes/models"
	"github.com/MousaZa/library-app-go/likes/server"
	"github.com/MousaZa/library-app-go/likes/storage"
	"github.com/hashicorp/go-hclog"
	"github.com/joho/godotenv"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"

	protos "github.com/MousaZa/library-app-go/likes/protos/likes"
)

func main() {
	log := hclog.Default()

	log.Info("Starting likes server" + os.Getenv("DB_HOST"))

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

	err = models.MigrateLikes(db)

	if err != nil {
		log.Error("Unable to migrate likes", "error", err)
		os.Exit(1)
	}

	gs := grpc.NewServer()
	cs := server.NewServer(log, db)

	protos.RegisterLikesServer(gs, cs)

	reflection.Register(gs)
	log.Info("listening on port 9094")
	l, err := net.Listen("tcp", ":9094")
	if err != nil {
		log.Error("unable to listen", err)
		os.Exit(1)
	}

	gs.Serve(l)
}

package main

import (
	"log"

	"github.com/MousaZa/library-app-go/auth/server"
)

func main() {
	if _, err := server.NewServer(":8080"); err != nil {
		log.Fatal("Failed to start server\n")
	}
}

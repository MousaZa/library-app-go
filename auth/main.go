package main

import (
	"fmt"
	"log"
	"os"

	"github.com/MousaZa/library-app-go/auth/clients"
	"github.com/MousaZa/library-app-go/auth/models"
	"github.com/MousaZa/library-app-go/auth/server"
	"github.com/MousaZa/library-app-go/auth/storage"
	borrows "github.com/MousaZa/library-app-go/borrows/protos/borrows"
	likes "github.com/MousaZa/library-app-go/likes/protos/likes"
	notifications "github.com/MousaZa/library-app-go/notifications/protos/notifications"
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
		os.Exit(1)
	}

	err = models.MigrateUsers(db)

	if err != nil {
		l.Error("Unable to migrate books", "error", err)
		os.Exit(1)
	}

	// creds := credentials.NewTLS(&tls.Config{InsecureSkipVerify: true})

	// remember to update address to use the new NGINX listen port

	// Likes client
	conn, err := grpc.Dial("proxy:80", grpc.WithInsecure())
	if err != nil {
		fmt.Printf("Failed to connect to Likes service: %v", err)
		// log.Fatalf("Failed to connect to Likes service: %v", err)
	}
	defer conn.Close()
	fmt.Printf("Starting likes server, conn: %v", conn.Target())
	// l.Info("Starting likes server", likesConn.Target())

	// // Borrows client
	// borrowsConn, err := grpc.NewClient("proxy:80", grpc.WithInsecure())
	// l.Info("Starting borrows server", borrowsConn.CanonicalTarget())
	// if err != nil {
	// 	panic(err)
	// }

	// defer borrowsConn.Close()

	// // Notifications client
	// notificationsconn, err := grpc.NewClient("proxy:80", grpc.WithInsecure())
	// if err != nil {
	// 	panic(err)
	// }

	// defer notificationsconn.Close()

	// create client
	borrowsClient := borrows.NewBorrowsClient(conn)
	likesClient := likes.NewLikesClient(conn)
	notificationsClient := notifications.NewNotificationsClient(conn)

	bc := clients.NewBorrowsClient(borrowsClient, db)
	lc := clients.NewLikesClient(likesClient)
	nc := clients.NewNotificationsClient(notificationsClient)

	if _, err := server.NewServer(":8080", db, bc, lc, nc); err != nil {
		log.Fatal("Failed to start server\n")
	}
}

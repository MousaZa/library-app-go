package main

import (
	"fmt"
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
		fmt.Printf("Unable to connect to database: %v", err)
		log.Error("Unable to connect to database", "error", err)
		os.Exit(1)
	}

	err = models.MigrateLikes(db)

	if err != nil {
		fmt.Printf("Unable to migrate likes: %v", err)
		log.Error("Unable to migrate likes", "error", err)
		os.Exit(1)
	}

	gs := grpc.NewServer()
	cs := server.NewServer(log, db)
	reflection.Register(gs)
	protos.RegisterLikesServer(gs, cs)

	// Wrap the gRPC server with gRPC-Web support
	// grpcWebServer := grpcweb.WrapServer(gs,
	// 	grpcweb.WithOriginFunc(func(origin string) bool {
	// 		// Allow all origins for simplicity, but restrict this in production
	// 		return true
	// 	}),
	// )

	// // Set up the HTTP handler to handle gRPC-Web requests and CORS
	// httpServer := &http.Server{
	// 	Handler: http.HandlerFunc(func(resp http.ResponseWriter, req *http.Request) {
	// 		// Handle gRPC-Web and standard gRPC traffic
	// 		if grpcWebServer.IsGrpcWebRequest(req) || grpcWebServer.IsGrpcWebSocketRequest(req) {
	// 			grpcWebServer.ServeHTTP(resp, req)
	// 		} else {
	// 			// Return a 404 for non-gRPC requests
	// 			http.NotFound(resp, req)
	// 		}
	// 	}),
	// }

	// Listen on port 9094 for incoming requests
	log.Info("Listening on port 9094")
	l, err := net.Listen("tcp", ":9094")
	if err != nil {
		fmt.Printf("Unable to listen: %v", err)
		log.Error("Unable to listen", "error", err)
		os.Exit(1)
	}

	// Start the HTTP server
	if err := gs.Serve(l); err != nil {
		fmt.Printf("Unable to listen: %v", err)
		log.Error("Failed to serve", "err", err)
	}
}

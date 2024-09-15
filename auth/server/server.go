package server

import (
	"fmt"
	"time"

	"github.com/MousaZa/library-app-go/auth/clients"
	"github.com/MousaZa/library-app-go/auth/token"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/hashicorp/go-hclog"
	"gorm.io/gorm"
)

type Server struct {
	tokenMaker    *token.PasetoMaker
	router        *gin.Engine
	borrowsClient *clients.BorrowsClient
	db            *gorm.DB
	l             hclog.Logger
}

func NewServer(address string, db *gorm.DB, bc *clients.BorrowsClient) (*Server, error) {

	// Initialize Paseto token maker
	tokenMaker, err := token.NewPaseto("abcdefghijkl12345678901234567890")
	if err != nil {
		return nil, fmt.Errorf("Couldn't create token maker: %w\n", err)
	}

	// Create a new server instance
	server := &Server{
		tokenMaker:    tokenMaker,
		db:            db,
		l:             hclog.Default(),
		borrowsClient: bc,
	}

	// Set up routes and run the server
	server.setRoutes()

	server.router.Run(address)

	return server, nil
}
func (server *Server) setRoutes() {
	router := gin.Default()

	// Group routes with authentication middleware
	auth := router.Group("/").Use(cors.New(cors.Config{
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"PUT", "get", "POST", "DELETE"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	})).Use(AuthMiddleware(*server.tokenMaker))

	auth.POST("/borrow", server.borrowsClient.AddBorrow)
	auth.DELETE("/delete/:id", server.deleteUser)
	auth.GET("/user", server.getUserData)
	router.POST("/create", server.createUser)
	router.POST("/login", server.login)
	server.router = router
}

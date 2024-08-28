package server

import (
	"fmt"

	"github.com/MousaZa/library-app-go/auth/token"
	"github.com/gin-gonic/gin"
)

type Server struct {
	tokenMaker *token.PasetoMaker
	router     *gin.Engine
}

func NewServer(address string) (*Server, error) {
	// Initialize Paseto token maker
	tokenMaker, err := token.NewPaseto("abcdefghijkl12345678901234567890")
	if err != nil {
		return nil, fmt.Errorf("Couldn't create token maker: %w\n", err)
	}

	// Create a new server instance
	server := &Server{
		tokenMaker: tokenMaker,
	}

	// Set up routes and run the server
	server.setRoutes()
	server.router.Run(address)

	return server, nil
}
func (server *Server) setRoutes() {
	router := gin.Default()

	// Group routes with authentication middleware
	auth := router.Group("/").Use(AuthMiddleware(*server.tokenMaker))
	auth.DELETE("/delete/:id", server.deleteUser)
	router.POST("/create", server.createUser)
	router.POST("/login", server.login)

	server.router = router
}

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
	tokenMaker          *token.PasetoMaker
	router              *gin.Engine
	borrowsClient       *clients.BorrowsClient
	likesClient         *clients.LikesClient
	notificationsClient *clients.NotificationsClient
	db                  *gorm.DB
	l                   hclog.Logger
}

func NewServer(address string, db *gorm.DB, bc *clients.BorrowsClient, lc *clients.LikesClient, nc *clients.NotificationsClient) (*Server, error) {

	// Initialize Paseto token maker
	tokenMaker, err := token.NewPaseto("abcdefghijkl12345678901234567890")
	if err != nil {
		return nil, fmt.Errorf("couldn't create token maker: %w", err)
	}

	// Create a new server instance
	server := &Server{
		tokenMaker:          tokenMaker,
		db:                  db,
		l:                   hclog.Default(),
		borrowsClient:       bc,
		notificationsClient: nc,
		likesClient:         lc,
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

	auth.GET("/auth/notifications", server.notificationsClient.GetUserNotifications)
	auth.PUT("/auth/notifications/:id", server.notificationsClient.MarkNotificationAsRead)
	auth.POST("/auth/borrows", server.borrowsClient.AddBorrow)
	auth.POST("/auth/like/:id", server.likesClient.AddLike)
	auth.DELETE("/auth/like/:id", server.likesClient.DeleteLike)
	auth.GET("/auth/like/:id", server.likesClient.GetLike)
	auth.DELETE("/auth/delete/:id", server.deleteUser)
	auth.GET("/auth/user", server.getUserData)
	auth.GET("/auth/borrows/user", server.borrowsClient.GetUserBorrows)
	auth.GET("/auth/borrows/o/user", server.borrowsClient.GetUserOnGoingBorrows)
	router.POST("/auth/create", server.createUser)
	router.POST("/auth/notifications/:id", server.notificationsClient.PushNotification)
	router.POST("/auth/login", server.login)
	server.router = router
}

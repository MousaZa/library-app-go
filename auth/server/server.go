package server

import (
	// "fmt"
	"fmt"

	"github.com/MousaZa/library-app-go/auth/clients"
	"github.com/MousaZa/library-app-go/auth/token"
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
	tokenMaker, err := token.NewPaseto()
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
	gin.SetMode(gin.ReleaseMode)
	router := gin.Default()

	// config := cors.Config{
	// 	AllowOrigins:     []string{"*"},                                                           // Allow all origins
	// 	AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},                     // Allowed HTTP methods
	// 	AllowHeaders:     []string{"Origin", "Content-Type", "Bearer", "Accept", "Authorization"}, // Allowed headers
	// 	ExposeHeaders:    []string{"Content-Length"},
	// 	AllowCredentials: true,
	// 	MaxAge:           12 * time.Hour,
	// }

	// Group routes with authentication middleware
	auth := router.Group("/").Use(AuthMiddleware(*server.tokenMaker))

	admin := router.Group("/").Use(AdminMiddleware(*server.tokenMaker))

	admin.GET("/auth/list/users", server.ListUsers)
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
	auth.GET("/auth/all-borrows", server.borrowsClient.GetAllBorrows)
	auth.GET("/auth/ongoing-borrows", server.borrowsClient.GetOnGoingBorrows)
	router.POST("/auth/create", server.createUser)
	router.POST("/auth/notifications/:id", server.notificationsClient.PushNotification)
	router.POST("/auth/login", server.login)
	server.router = router
}

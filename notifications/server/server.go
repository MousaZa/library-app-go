package server

import (
	"context"

	protos "github.com/MousaZa/library-app-go/notifications/protos/notifications"
	"github.com/hashicorp/go-hclog"
	"gorm.io/gorm"
)

type Server struct {
	log hclog.Logger
	DB  *gorm.DB
}

func NewServer(log hclog.Logger, db *gorm.DB) *Server {
	return &Server{log, db}
}

func (s *Server) GetUserNotifications(ctx context.Context, req *protos.GetUserNotificationsRequest) (*protos.GetUserNotificationsResponse, error) {
	return &protos.GetUserNotificationsResponse{}, nil
}

func (s *Server) PushNotification(ctx context.Context, req *protos.PushNotificationRequest) (*protos.MessageResponse, error) {
	return &protos.MessageResponse{}, nil
}

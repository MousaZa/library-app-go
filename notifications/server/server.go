package server

import (
	"context"

	"github.com/MousaZa/library-app-go/notifications/models"
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

	userID := req.UserId

	notifications := []models.Notification{}

	err := s.DB.Where("user_id = ?", userID).Find(&notifications).Error

	if err != nil {
		s.log.Error("Unable to get notifications", "error", err)
		return nil, err
	}

	return &protos.GetUserNotificationsResponse{}, nil
}

func (s *Server) PushNotification(ctx context.Context, req *protos.PushNotificationRequest) (*protos.MessageResponse, error) {

	notification := models.NewNotification(req.UserId, req.Type, req.Message)

	err := s.DB.Create(&notification).Error
	if err != nil {
		s.log.Error("Unable to push notification", "error", err)
		return nil, err
	}

	return &protos.{Message: "Notification pushed successfully"}, nil
}

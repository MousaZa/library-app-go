package server

import (
	"context"
	"fmt"

	"github.com/MousaZa/library-app-go/notifications/models"
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

	userID := req.UserId

	notifications := []models.Notification{}

	err := s.DB.Where("user_id = ?", userID).Find(&notifications).Error

	if err != nil {
		s.log.Error("Unable to get notifications", "error", err)
		return nil, err
	}

	resp := &protos.GetUserNotificationsResponse{}

	for _, notification := range notifications {
		s.log.Debug("Notification", "notification", notification)
		resp.Notifications = append(resp.Notifications, &protos.Notification{
			Id:      notification.ID,
			UserId:  notification.UserID,
			Type:    notification.Type,
			Message: notification.Message,
		})
	}

	return resp, nil
}

func (s *Server) PushNotification(ctx context.Context, req *protos.PushNotificationRequest) (*protos.NMessageResponse, error) {

	n := models.Notification{}

	if err := s.DB.Where("user_id = ? AND type = ?", req.UserId, req.Type).First(&n).Error; err == nil {
		s.log.Info("Notification already exists", "notification", n)
		return nil, nil
	}

	fmt.Printf("Pushing notification for user %v\n", req.UserId)

	notification := models.NewNotification(req.UserId, req.Type, req.Message)

	err := s.DB.Create(&notification).Error
	if err != nil {
		s.log.Error("Unable to push notification", "error", err)
		return nil, err
	}

	return &protos.NMessageResponse{Message: "Notification pushed successfully"}, nil
}

func (s *Server) MarkNotificationAsRead(ctx context.Context, req *protos.MarkNotificationAsReadRequest) (*protos.NMessageResponse, error) {

	notification := models.Notification{}

	err := s.DB.Where("id = ?", req.NotificationId).First(&notification).Error

	if err != nil {
		s.log.Error("Unable to get notification", "error", err)
		return nil, err
	}

	notification.Status = "read"

	err = s.DB.Save(&notification).Error

	if err != nil {
		s.log.Error("Unable to update notification", "error", err)
		return nil, err
	}

	return &protos.NMessageResponse{Message: "Notification updated successfully"}, nil
}

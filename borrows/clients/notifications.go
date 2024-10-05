package clients

import (
	"context"
	"fmt"

	// likes "github.com/MousaZa/library-app-go/likes/protos/likes"

	notifications "github.com/MousaZa/library-app-go/notifications/protos/notifications"
	// "github.com/gin-gonic/gin"
)

type NotificationsClient struct {
	client notifications.NotificationsClient
}

func NewNotificationsClient(client notifications.NotificationsClient) *NotificationsClient {
	return &NotificationsClient{client: client}
}

type NotificationRequest struct {
	Message string `json:"message"`
	Type    string `json:"type"`
}

func (c *NotificationsClient) PushNotification(userId int64, message string, notificationType string) (*notifications.MessageResponse, error) {

	resp, err := c.client.PushNotification(context.Background(), &notifications.PushNotificationRequest{UserId: userId, Message: message, Type: notificationType})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		return nil, err
	}
	return resp, nil
}

func (c *NotificationsClient) GetUserNotifications() {

}

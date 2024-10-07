package clients

import (
	"context"
	"fmt"
	"net/http"
	"strconv"

	// likes "github.com/MousaZa/library-app-go/likes/protos/likes"

	notifications "github.com/MousaZa/library-app-go/notifications/protos/notifications"
	"github.com/gin-gonic/gin"
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

func (c *NotificationsClient) PushNotification(ctx *gin.Context) {

	nr := &NotificationRequest{}

	if err := ctx.ShouldBindJSON(nr); err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	userId, err := strconv.Atoi(ctx.Param("id"))

	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	resp, err := c.client.PushNotification(context.Background(), &notifications.PushNotificationRequest{UserId: int64(userId), Message: nr.Message, Type: nr.Type})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"response": resp.Message})
}

func (c *NotificationsClient) GetUserNotifications(ctx *gin.Context) {
	userId := ctx.MustGet("userId").(int64)
	resp, err := c.client.GetUserNotifications(context.Background(), &notifications.GetUserNotificationsRequest{UserId: userId})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, resp.Notifications)
}

func (c *NotificationsClient) MarkNotificationAsRead(ctx *gin.Context) {
	notificationId, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	resp, err := c.client.MarkNotificationAsRead(context.Background(), &notifications.MarkNotificationAsReadRequest{NotificationId: int64(notificationId)})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, resp.Message)
}

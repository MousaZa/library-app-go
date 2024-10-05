package models

import "gorm.io/gorm"

type Notification struct {
	ID      int64  `json:"id" gorm:"primary_key;autoIncrement"`
	UserID  int64  `json:"user_id"`
	Message string `json:"message"`
	Type    string `json:"type"`
	Status  string `json:"status"`
}

func NewNotification(userID int64, Type string, message string) *Notification {
	return &Notification{
		UserID:  userID,
		Message: message,
		Type:    Type,
		Status:  "unread",
	}
}

func MigrateNotifications(db *gorm.DB) error {
	return db.AutoMigrate(&Notification{})
}

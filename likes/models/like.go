package models

import "gorm.io/gorm"

type Like struct {
	ID     int64 `gorm:"primaryKey"`
	UserID int64
	BookID int64
}

func MigrateLikes(db *gorm.DB) error {
	return db.AutoMigrate(&Like{})
}

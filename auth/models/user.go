package models

import "gorm.io/gorm"

type User struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

func MigrateUsers(db *gorm.DB) error {
	return db.AutoMigrate(&User{})
}

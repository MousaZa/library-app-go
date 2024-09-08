package models

import "gorm.io/gorm"

type Book struct {
	Id        int    `json:"id" gorm:"primary key;autoIncrement"`
	Title     string `json:"title"`
	Author    string `json:"author"`
	Category  string `json:"category"`
	CoverURL  string `json:"coverURL"`
	Language  string `json:"language"`
	Likes     int    `json:"likes"`
	Borrows   int    `json:"borrows"`
	Summary   string `json:"summary"`
	Available bool   `json:"available"`
}

func MigrateBooks(db *gorm.DB) error {
	return db.AutoMigrate(&Book{})
}

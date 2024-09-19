package models

import (
	"time"

	"gorm.io/gorm"
)

type Borrow struct {
	ID        int64     `json:"id" gorm:"primary key;autoIncrement"`
	BookID    int64     `json:"BookId"`
	UserID    int64     `json:"UserId"`
	StartDate time.Time `json:"start_date"`
	EndDate   time.Time `json:"end_date"`
	Status    string    `json:"returned"`
}

func NewBorrow(bookID, userID int64, duration time.Duration) *Borrow {
	return &Borrow{
		BookID:    bookID,
		UserID:    userID,
		StartDate: time.Now(),
		EndDate:   time.Now().Add(duration),
		Status:    "pending",
	}
}

type BorrowRequest struct {
	BookID int `json:"BookId"`
	UserID int `json:"UserId"`
}

func NewBorrowRequest(bookID, userID int) *BorrowRequest {
	return &BorrowRequest{
		BookID: bookID,
		UserID: userID,
	}
}

func MigrateBorrows(db *gorm.DB) error {
	return db.AutoMigrate(&Borrow{})
}

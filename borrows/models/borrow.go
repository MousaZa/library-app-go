package models

import (
	"time"

	"google.golang.org/protobuf/types/known/timestamppb"
	"gorm.io/gorm"
)

type Borrow struct {
	ID               int64  `json:"id" gorm:"primary key;autoIncrement"`
	BookID           int64  `json:"BookId"`
	UserID           int64  `json:"UserId"`
	StartDateSeconds int    `json:"start_date_seconds"`
	EndDateSeconds   int    `json:"end_date_seconds"`
	StartDateNanoSec int    `json:"start_date_nano_sec"`
	EndDateNanoSec   int    `json:"end_date_nano_sec"`
	Status           string `json:"status"`
}

func NewBorrow(bookID, userID int64, duration time.Duration) *Borrow {
	// now :=
	// sd, _ := proto.Marshal(timestamppb.Now())
	// ed, _ := proto.Marshal(timestamppb.New(time.Now().Add(duration)))
	// proto.Unmarshal(bytes, msg)
	return &Borrow{
		BookID:           bookID,
		UserID:           userID,
		StartDateSeconds: int(timestamppb.Now().Seconds),
		EndDateSeconds:   int(timestamppb.New(time.Now().Add(duration)).Seconds),
		StartDateNanoSec: int(timestamppb.Now().Nanos),
		EndDateNanoSec:   int(timestamppb.New(time.Now().Add(duration)).Nanos),
		Status:           "pending",
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

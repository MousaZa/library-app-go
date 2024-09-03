package server

import (
	"context"
	"time"

	"github.com/MousaZa/library-app-go/borrows/models"
	protos "github.com/MousaZa/library-app-go/borrows/protos/borrows"
	"github.com/hashicorp/go-hclog"
	"gorm.io/gorm"
)

type BorrowsServer struct {
	l  hclog.Logger
	db *gorm.DB
}

func NewBorrowsServer(l hclog.Logger, db *gorm.DB) *BorrowsServer {
	return &BorrowsServer{l: l, db: db}
}

func (s *BorrowsServer) AddBorrow(ctx context.Context, req *protos.AddBorrowRequest) (*protos.AddBorrowResponse, error) {
	borrow := models.NewBorrow(req.BookId, req.UserId, 7*24*time.Hour)

	err := s.db.Create(&borrow).Error
	if err != nil {
		s.l.Error("Failed to create borrow", "error", err)
		return nil, err
	}
	return &protos.AddBorrowResponse{Message: "Borrow Was Added Successfully"}, nil
}

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

func (s *BorrowsServer) AddBorrow(ctx context.Context, req *protos.AddBorrowRequest) (*protos.MessageResponse, error) {

	borrow := models.NewBorrow(req.BookId, req.UserId, 7*24*time.Hour)

	err := s.db.Create(&borrow).Error
	if err != nil {
		s.l.Error("Failed to create borrow", "error", err)
		return nil, err
	}
	return &protos.MessageResponse{Message: "Borrow Was Added Successfully"}, nil
}

func (s *BorrowsServer) GetAllBorrows(ctx context.Context, req *protos.GetAllBorrowsRequest) (*protos.GetBorrowsResponse, error) {
	var borrows []models.Borrow
	err := s.db.Find(&borrows).Error
	if err != nil {
		s.l.Error("Failed to get borrows", "error", err)
		return nil, err
	}

	resp := &protos.GetBorrowsResponse{}

	for _, borrow := range borrows {
		resp.Borrows = append(resp.Borrows, &protos.Borrow{
			Id:     borrow.ID,
			BookId: borrow.BookID,
			UserId: borrow.UserID,
		})
	}

	return resp, nil
}

func (s *BorrowsServer) GetUserBorrows(ctx context.Context, req *protos.GetUserBorrowsRequest) (*protos.GetBorrowsResponse, error) {
	return nil, nil
}

func (s *BorrowsServer) GetBookBorrows(ctx context.Context, req *protos.GetBookBorrowsRequest) (*protos.GetBorrowsResponse, error) {
	return nil, nil
}

func (s *BorrowsServer) DeleteBorrow(ctx context.Context, req *protos.DeleteBorrowRequest) (*protos.MessageResponse, error) {
	err := s.db.Delete(&models.Borrow{}, req.Id).Error
	if err != nil {
		s.l.Error("Failed to delete borrow", "error", err)
		return nil, err
	}
	return &protos.MessageResponse{Message: "Borrow Was Deleted Successfully"}, nil
}

func (s *BorrowsServer) UpdateBorrow(ctx context.Context, req *protos.UpdateBorrowRequest) (*protos.MessageResponse, error) {
	return nil, nil
}

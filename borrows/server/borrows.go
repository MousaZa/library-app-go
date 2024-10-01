package server

import (
	"context"
	"errors"
	"fmt"
	"net/http"
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

	link := fmt.Sprintf("http://localhost:9090/books/borrow/%v", req.BookId)

	resp, err := http.Post(link, "application/json", nil)

	if err != nil {
		s.l.Error("Failed to post to books", "error", err)
		return nil, err
	}

	if resp.StatusCode != http.StatusCreated {
		return nil, errors.New("Failed to post to books")
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
	var borrows []models.Borrow
	userId := req.UserId
	fmt.Printf("User ID: %d\n", userId)
	err := s.db.Where("user_id = ? AND returned = ?", userId, true).Find(&borrows).Error
	if err != nil {
		s.l.Error("Failed to get borrows", "error", err)
		return nil, err
	}

	resp := &protos.GetBorrowsResponse{}

	for _, borrow := range borrows {
		resp.Borrows = append(resp.Borrows, &protos.Borrow{
			Id:         borrow.ID,
			BookId:     borrow.BookID,
			UserId:     borrow.UserID,
			BorrowDate: borrow.StartDate.Format(time.RFC3339),
			ReturnDate: borrow.EndDate.Format(time.RFC3339),
			Status:     borrow.Status,
			Returned:   borrow.Returned,
		})
	}
	return resp, nil
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

func (s *BorrowsServer) GetUserOnGoingBorrows(ctx context.Context, req *protos.GetUserBorrowsRequest) (*protos.GetBorrowsResponse, error) {
	var borrows []models.Borrow
	userId := req.UserId
	fmt.Printf("User ID: %d\n", userId)
	err := s.db.Where("user_id = ? AND returned = ?", userId, false).Find(&borrows).Error
	if err != nil {
		s.l.Error("Failed to get borrows", "error", err)
		return nil, err
	}

	resp := &protos.GetBorrowsResponse{}

	for _, borrow := range borrows {
		resp.Borrows = append(resp.Borrows, &protos.Borrow{
			Id:         borrow.ID,
			BookId:     borrow.BookID,
			UserId:     borrow.UserID,
			BorrowDate: borrow.StartDate.Format(time.RFC3339),
			ReturnDate: borrow.EndDate.Format(time.RFC3339),
			Status:     borrow.Status,
			Returned:   borrow.Returned,
		})
	}
	return resp, nil
}

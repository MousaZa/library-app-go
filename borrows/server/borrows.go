package server

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/MousaZa/library-app-go/borrows/clients"
	"github.com/MousaZa/library-app-go/borrows/models"
	protos "github.com/MousaZa/library-app-go/borrows/protos/borrows"
	"github.com/hashicorp/go-hclog"
	"google.golang.org/protobuf/types/known/timestamppb"
	"gorm.io/gorm"
)

type BorrowsServer struct {
	l  hclog.Logger
	db *gorm.DB
	nc *clients.NotificationsClient
}

func NewBorrowsServer(l hclog.Logger, db *gorm.DB, nc *clients.NotificationsClient) *BorrowsServer {
	return &BorrowsServer{l: l, db: db, nc: nc}
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
		return nil, errors.New("failed to post to books")
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
		if int64(borrow.EndDateSeconds) < time.Now().AddDate(0, 0, -1).Unix() {
			s.nc.PushNotification(borrow.UserID, "You have a book that is due soon", "warning")
		}
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
	err := s.db.Where("user_id = ? AND status = ?", userId, "returned").Find(&borrows).Error
	if err != nil {
		s.l.Error("Failed to get borrows", "error", err)
		return nil, err
	}

	resp := &protos.GetBorrowsResponse{}

	for _, borrow := range borrows {
		// sd := &timestamppb.Timestamp{}
		// // err = proto.Unmarshal(borrow.StartDate, sd)
		// if err != nil {
		// 	s.l.Error("Failed to unmarshal start date", "error", err)
		// 	return nil, err
		// }

		// ed := &timestamppb.Timestamp{}
		// // err = proto.Unmarshal(borrow.StartDate, ed)
		// if err != nil {
		// 	s.l.Error("Failed to unmarshal ednd date", "error", err)
		// 	return nil, err
		// }

		resp.Borrows = append(resp.Borrows, &protos.Borrow{
			Id:         borrow.ID,
			BookId:     borrow.BookID,
			UserId:     borrow.UserID,
			BorrowDate: timestamppb.New(time.Unix(int64(borrow.StartDateSeconds), int64(borrow.StartDateNanoSec))),
			ReturnDate: timestamppb.New(time.Unix(int64(borrow.EndDateSeconds), int64(borrow.EndDateNanoSec))),
			Status:     borrow.Status,
		})
	}
	fmt.Printf("Borrows: %v\n", resp.Borrows)
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
	err := s.db.Where("user_id = ? AND status != ?", userId, "returned").Find(&borrows).Error
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
			BorrowDate: timestamppb.New(time.Unix(int64(borrow.StartDateSeconds), int64(borrow.StartDateNanoSec))),
			ReturnDate: timestamppb.New(time.Unix(int64(borrow.EndDateSeconds), int64(borrow.EndDateNanoSec))),
			Status:     borrow.Status,
		})
	}
	fmt.Printf("Ongoing Borrows: %v\n", resp.Borrows)

	return resp, nil
}

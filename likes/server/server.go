package server

import (
	"context"
	"fmt"
	"net/http"

	"github.com/MousaZa/library-app-go/likes/models"
	protos "github.com/MousaZa/library-app-go/likes/protos/likes"
	"github.com/hashicorp/go-hclog"
	"gorm.io/gorm"
)

type Server struct {
	log hclog.Logger
	DB  *gorm.DB
}

func NewServer(log hclog.Logger, db *gorm.DB) *Server {
	return &Server{log, db}
}

func (s *Server) AddLike(ctx context.Context, req *protos.LikeRequest) (*protos.BoolResponse, error) {
	s.log.Info("Adding like")

	like := models.Like{
		UserID: req.UserId,
		BookID: req.BookId,
	}

	err := s.DB.Create(&like).Error
	if err != nil {
		s.log.Error("Failed to create like", "error", err)
		return nil, err
	}
	link := fmt.Sprintf("http://localhost:9090/books/like/%v", req.BookId)
	_, err = http.Post(link, "application/json", nil)
	if err != nil {
		s.log.Error("Failed to create like", "error", err)
		return nil, err
	}
	return &protos.BoolResponse{Response: true}, nil
}

func (s *Server) GetLike(ctx context.Context, req *protos.LikeRequest) (*protos.BoolResponse, error) {

	like := models.Like{}

	err := s.DB.Where("user_id = ? AND book_id = ?", req.UserId, req.BookId).First(&like).Error
	if err != nil {
		return &protos.BoolResponse{Response: false}, nil
	}

	return &protos.BoolResponse{Response: true}, nil
}
func (s *Server) DeleteLike(ctx context.Context, req *protos.LikeRequest) (*protos.BoolResponse, error) {
	like := models.Like{}

	err := s.DB.Where("user_id = ? AND book_id = ?", req.UserId, req.BookId).Delete(&like).Error
	if err != nil {
		return nil, err
	}

	link := fmt.Sprintf("http://localhost:9090/books/remove_like/%v", req.BookId)
	_, err = http.Post(link, "application/json", nil)
	if err != nil {
		s.log.Error("Failed to create like", "error", err)
		return nil, err
	}
	return &protos.BoolResponse{Response: true}, nil
}

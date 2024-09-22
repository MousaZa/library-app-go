package server

import (
	"context"

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
	// Add like logic here
	return &protos.BoolResponse{Response: true}, nil
}

func (s *Server) GetLike(ctx context.Context, req *protos.LikeRequest) (*protos.BoolResponse, error) {
	// Add like logic here
	return &protos.BoolResponse{Response: true}, nil
}
func (s *Server) DeleteLike(ctx context.Context, req *protos.LikeRequest) (*protos.BoolResponse, error) {
	// Add like logic here
	return &protos.BoolResponse{Response: true}, nil
}

package server

import (
	"context"

	protos "github.com/MousaZa/library-app-go/books/protos/books"
	"github.com/hashicorp/go-hclog"
	"gorm.io/gorm"
)

type BooksServer struct {
	l  hclog.Logger
	db *gorm.DB
}

func NewBooksServer(l hclog.Logger, db *gorm.DB) *BooksServer {
	return &BooksServer{l: l, db: db}
}

func (s *BooksServer) AddBook(ctx context.Context, req *protos.AddBookRequest) (*protos.AddBookResponse, error) {
	book := protos.Book{
		Title:     req.Title,
		Author:    req.Author,
		Category:  req.Category,
		CoverURL:  req.CoverURL,
		Language:  req.Language,
		Likes:     0,
		Borrows:   0,
		Summary:   req.Summary,
		Available: true,
	}

	err := s.db.Create(&book).Error
	if err != nil {
		s.l.Error("Failed to create book", "error", err)
		return nil, err
	}
	return &protos.AddBookResponse{Message: "Book Was Added Successfully"}, nil
}

func (s *BooksServer) GetBooks(ctx context.Context, req *protos.GetBooksRequest) (*protos.GetBooksResponse, error) {
	var books []*protos.Book
	err := s.db.Find(&books).Error
	if err != nil {
		s.l.Error("Failed to get books", "error", err)
		return nil, err
	}
	booksResponse := protos.GetBooksResponse{Books: books}
	return &booksResponse, nil
}

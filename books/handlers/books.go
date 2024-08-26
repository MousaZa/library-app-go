package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/MousaZa/library-app-go/books/data"
	"github.com/hashicorp/go-hclog"
)

type BooksHandler struct {
	l hclog.Logger
}

func NewBooksHandler(l hclog.Logger) *BooksHandler {
	return &BooksHandler{l}
}

func (bh *BooksHandler) GetBooks(rw http.ResponseWriter, r *http.Request) {
	b := data.GetBooks()

	err := json.NewEncoder(rw).Encode(b)
	if err != nil {
		http.Error(rw, "Unable to marshal json", http.StatusInternalServerError)
	}
}

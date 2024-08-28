// Package classification of Book API
//
// Documentation for Book API
//
//	Schemes: http
//	BasePath: /
//	Version: 1.0.0
//
//	Consumes:
//	- application/json
//
//	Produces:
//	- application/json
//
// swagger:meta
package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/MousaZa/library-app-go/books/models"
	"github.com/go-openapi/runtime/middleware"
	"github.com/gorilla/mux"
	"gorm.io/gorm"
)

// A list of books returns in the response
// swagger:response booksResponse
type bookResponse struct {
	// All books in the system
	// in: body
	body models.Book
}

// A book returns in the response
// swagger:response bookResponse
type booksResponse struct {
	// A single book in the system
	// in: body
	body []models.Book
}

// swagger:response noContent
type bookssNoContent struct {
}

// swagger:parameters deleteBook updateBook getBook
type productIdParameterWrapper struct {
	// the id of the target book
	// in: path
	// required: true
	ID int `json:"id"`
}

// swagger:parameters addBook updateBook
type productParameterWrapper struct {
	// The Book data
	// in: body
	// required: true
	Product models.Book `json:"book"`
}

type Repository struct {
	DB *gorm.DB
}

// swagger:route POST /books books addBook
// responses:
//
//	201: noContent

// AddBook adds a book to the database
func (r *Repository) AddBook(w http.ResponseWriter, req *http.Request) {
	book := models.Book{}
	err := json.NewDecoder(req.Body).Decode(&book)
	if err != nil {
		http.Error(w, "Unable to unmarshal json", http.StatusBadRequest)
		return
	}
	err = r.DB.Create(&book).Error
	if err != nil {
		http.Error(w, "Unable to insert book", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Book added successfully\n"))
}

// swagger:route GET /books books getBooks
// Returns a list of books
// responses:
//
//	200: booksResponse
func (r *Repository) GetBooks(w http.ResponseWriter, req *http.Request) {
	books := &[]models.Book{}
	err := r.DB.Find(&books).Error
	if err != nil {
		http.Error(w, "Unable to get books", http.StatusInternalServerError)
		return
	}
	err = json.NewEncoder(w).Encode(books)
	if err != nil {
		http.Error(w, "Unable to marshal json", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
}

// swagger:route GET /books/{id} books getBook
// Returns a book
// responses:
//
//	200: bookResponse
func (r *Repository) GetBook(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	id := vars["id"]
	if id == "" {
		http.Error(w, "Invalid book id", http.StatusBadRequest)
		return
	}

	book := &models.Book{}
	err := r.DB.Where("id = ?", id).First(&book).Error
	if err != nil {
		http.Error(w, "Book not found", http.StatusNotFound)
		return
	}
	err = json.NewEncoder(w).Encode(book)
	if err != nil {
		http.Error(w, "Unable to marshal json", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
}

// swagger:route DELETE /books/{id} books deleteBook
// responses:
//
//	201: noContent

// DeleteBook deletes a product form the database
func (r *Repository) DeleteBook(w http.ResponseWriter, req *http.Request) {
	vars := mux.Vars(req)
	id := vars["id"]
	if id == "" {
		http.Error(w, "Invalid book id", http.StatusBadRequest)
		return
	}

	err := r.DB.Delete(&models.Book{}, id).Error
	if err != nil {
		http.Error(w, "Unable to delete book", http.StatusInternalServerError)
		return
	}
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Book deleted successfully\n"))
}

func (r *Repository) SetupRoutes(app *mux.Router) {
	app.HandleFunc("/books", r.GetBooks).Methods("GET")
	app.HandleFunc("/books/{id}", r.GetBook).Methods("GET")
	app.HandleFunc("/books", r.AddBook).Methods("POST")
	app.HandleFunc("/books/{id}", r.DeleteBook).Methods("DELETE")

	ops := middleware.RedocOpts{SpecURL: "/swagger.yaml"}
	sh := middleware.Redoc(ops, nil)

	app.Handle("/docs", sh)
	app.Handle("/swagger.yaml", http.FileServer(http.Dir("./")))
}

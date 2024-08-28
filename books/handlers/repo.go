package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/MousaZa/library-app-go/books/models"
	"github.com/gorilla/mux"
	"gorm.io/gorm"
)

type Repository struct {
	DB *gorm.DB
}

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
}

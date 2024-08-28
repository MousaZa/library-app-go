package main

import (
	"context"
	"encoding/json"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/MousaZa/library-app-go/books/models"
	"github.com/MousaZa/library-app-go/books/storage"
	"github.com/gorilla/mux"
	"github.com/hashicorp/go-hclog"
	"github.com/joho/godotenv"
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

func main() {
	l := hclog.Default()

	err := godotenv.Load(".env")
	if err != nil {
		l.Error("Unable to get env", "error", err)
	}

	config := &storage.Config{
		Host:     os.Getenv("DB_HOST"),
		Port:     os.Getenv("DB_PORT"),
		User:     os.Getenv("DB_USER"),
		Password: os.Getenv("DB_PASS"),
		DBName:   os.Getenv("DB_NAME"),
		SSLMode:  os.Getenv("DB_SSLMODE"),
	}

	db, err := storage.NewConnection(config)

	if err != nil {
		l.Error("Unable to connect to database", "error", err)
	}

	err = models.MigrateBooks(db)
	if err != nil {
		l.Error("Unable to migrate books", "error", err)
	}

	r := Repository{
		DB: db,
	}

	router := mux.NewRouter()

	r.SetupRoutes(router)

	s := http.Server{
		Addr:    ":9090",
		Handler: router,
	}

	go func() {
		l.Info("Starting server on port 9090")
		err := s.ListenAndServe()
		if err != nil {
			l.Error("Unable to start server", "error", err)
		}
	}()

	sigChan := make(chan os.Signal)
	signal.Notify(sigChan, os.Interrupt)
	signal.Notify(sigChan, os.Kill)

	sig := <-sigChan
	l.Info("Received terminate, graceful shutdown", sig)
	tc, _ := context.WithTimeout(context.Background(), 30*time.Second)
	s.Shutdown(tc)

}

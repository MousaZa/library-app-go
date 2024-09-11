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
	"net/http"
	"strconv"

	"github.com/MousaZa/library-app-go/books/models"
	"github.com/gin-gonic/gin"
	"github.com/hashicorp/go-hclog"
	"github.com/mvrilo/go-redoc"
	ginredoc "github.com/mvrilo/go-redoc/gin"
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
func (r *Repository) AddBook(ctx *gin.Context) {
	book := models.Book{}
	err := ctx.BindJSON(&book)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}
	err = r.DB.Create(&book).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to add book"})
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "Book added successfully"})
}

// swagger:route GET /books books getBooks
// Returns a list of books
// responses:
//
//	200: booksResponse
func (r *Repository) GetBooks(ctx *gin.Context) {
	books := &[]models.Book{}
	search := ctx.Query("search")
	language := ctx.Query("language")
	category := ctx.Query("category")
	err := r.DB.Where("title LIKE ?", "%"+search+"%").Where("language LIKE ?", "%"+language+"%").Where("category LIKE ?", "%"+category+"%").Find(&books).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to get books"})
		return
	}
	ctx.JSON(http.StatusOK, books)
	// if language != "" {
	// 	err := r.DB.Where("language = ?", language).Find(&books).Error
	// 	if err != nil {
	// 		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to get books"})
	// 		return
	// 	}
	// 	ctx.JSON(http.StatusOK, books)
	// 	return
	// }
	// if category != "" {
	// 	err := r.DB.Where("category = ?", category).Find(&books).Error
	// 	if err != nil {
	// 		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to get books"})
	// 		return
	// 	}
	// 	ctx.JSON(http.StatusOK, books)
	// 	return
	// }
	// if search != "" {
	// 	err := r.DB.Where("title LIKE ?", "%"+search+"%").Find(&books).Error
	// 	if err != nil {
	// 		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to get books"})
	// 		return
	// 	}
	// 	ctx.JSON(http.StatusOK, books)
	// 	return
	// }
	// err := r.DB.Find(&books).Error
	// if err != nil {
	// 	ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to get books"})
	// 	return
	// }
	// ctx.JSON(http.StatusOK, books)
}

// swagger:route GET /books/{id} books getBook
// Returns a book
// responses:
//
//	200: bookResponse
func (r *Repository) GetBook(ctx *gin.Context) {
	id := ctx.Param("id")
	if id == "" {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
		return
	}

	book := &models.Book{}
	err := r.DB.Where("id = ?", id).First(&book).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to get book"})
		return
	}

	ctx.JSON(http.StatusOK, book)
}

// swagger:route DELETE /books/{id} books deleteBook
// responses:
//
//	201: noContent

// DeleteBook deletes a book form the database
func (r *Repository) DeleteBook(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	hclog.Default().Info("id", "id", id)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
		return
	}

	err = r.DB.Delete(&models.Book{}, id).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to delete book"})
		return
	}
	ctx.JSON(http.StatusNoContent, gin.H{"message": "Book deleted successfully"})
}

// swagger:route PUT /books/{id} books updateBook
// responses:
//
//	201: noContent

// UpdateBook updates a book on the database
func (r *Repository) UpdateBook(ctx *gin.Context) {
	id := ctx.Param("id")
	if id == "" {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
		return
	}

	book := &models.Book{}
	err := r.DB.Where("id = ?", id).First(&book).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to get book"})
		return
	}

	err = ctx.BindJSON(&book)
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	err = r.DB.Save(&book).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to update book"})
		return
	}

	ctx.JSON(http.StatusOK, book)
}

func (r *Repository) SetupRoutes(app *gin.Engine) {
	app.GET("/books", r.GetBooks)
	app.GET("/books/:id", r.GetBook)
	app.POST("/books", r.AddBook)
	app.DELETE("/books/:id", r.DeleteBook)
	app.PUT("/books/:id", r.UpdateBook)

	doc := redoc.Redoc{
		Title:       "Api Documentation",
		Description: "Documentation for Book API",
		SpecFile:    "./swagger.yaml",
		SpecPath:    "/swagger.yaml",
		DocsPath:    "/docs",
	}

	app.Use(ginredoc.New(doc))

}

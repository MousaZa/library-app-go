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
	"fmt"
	"net/http"
	"strconv"
	"time"

	"github.com/MousaZa/library-app-go/books/models"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/gorilla/websocket"
	"github.com/hashicorp/go-hclog"
	"github.com/mvrilo/go-redoc"
	ginredoc "github.com/mvrilo/go-redoc/gin"
	"gorm.io/gorm"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

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

// swagger:route POST /books/borrow/{id} books addBorrow
// responses:
//
//	201: noContent

// BorrowBook increments the borrow count of a book
func (r *Repository) BorrowBook(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
		return
	}
	err = r.DB.Exec("UPDATE books SET available = false WHERE id = ?", id).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to borrow book"})
		return
	}

	err = r.DB.Exec("UPDATE books SET borrows = borrows + 1 WHERE id = ?", id).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to borrow book"})
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "Book borrowed successfully"})
}

// swagger:route POST /books/like/{id} books LikeBook
// responses:
//
//	201: noContent

// LikeBook increments the likes count of a book
func (r *Repository) LikeBook(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
		return
	}

	err = r.DB.Exec("UPDATE books SET likes = likes + 1 WHERE id = ?", id).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to like book"})
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "Book liked successfully"})
}

// swagger:route POST /books/remove_like/{id} books RemoveLike
// responses:
//
//	201: noContent

// RemoveLike decrement the likes count of a book
func (r *Repository) RemoveLike(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
		return
	}

	err = r.DB.Exec("UPDATE books SET likes = likes - 1 WHERE id = ?", id).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to remove like"})
		return
	}
	ctx.JSON(http.StatusCreated, gin.H{"message": "like removed successfully"})
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
	book.Borrows = 0
	book.Likes = 0
	book.Available = true

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

	search := ctx.Query("search")
	language := ctx.Query("language")
	category := ctx.Query("category")
	fmt.Printf("upgrading connection")
	conn, err := upgrader.Upgrade(ctx.Writer, ctx.Request, nil)
	if err != nil {
		fmt.Printf("Error upgrading connection: %v", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to upgrade connection"})
		return
	}
	defer conn.Close()

	initialBooks := &[]models.Book{}
	err = r.DB.Where("title LIKE ?", "%"+search+"%").Where("language LIKE ?", "%"+language+"%").Where("category LIKE ?", "%"+category+"%").Order("borrows DESC").Find(&initialBooks).Error
	if err != nil {
		conn.WriteMessage(websocket.TextMessage, []byte("Unable to get books"))
		return
	}
	conn.WriteJSON(initialBooks)

	for {
		time.Sleep(time.Second)
		books := &[]models.Book{}
		err := r.DB.Where("title LIKE ?", "%"+search+"%").Where("language LIKE ?", "%"+language+"%").Where("category LIKE ?", "%"+category+"%").Order("borrows DESC").Find(&books).Error
		if err != nil {
			conn.WriteMessage(websocket.TextMessage, []byte("Unable to get books"))
			return
		}

		if !equalBooks(initialBooks, books) {
			conn.WriteJSON(books)
			initialBooks = books
		}
	}
}

func equalBooks(a, b *[]models.Book) bool {
	if len(*a) != len(*b) {
		return false
	}
	for i := range *a {
		if (*a)[i] != (*b)[i] {
			return false
		}
	}
	return true
}

// swagger:route GET /books/{id} books getBook
// Returns a book
// responses:
//
//	200: bookResponse
func (r *Repository) GetBook(ctx *gin.Context) {
	id, err := strconv.Atoi(ctx.Param("id"))
	if err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
		return
	}
	// if id == "" {
	// 	ctx.JSON(http.StatusBadRequest, gin.H{"error": "Invalid book id"})
	// 	return
	// }

	book := &models.Book{}
	err = r.DB.Where("id = ?", id).First(&book).Error
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

	cors := app.Group("/").Use(cors.New(cors.Config{
		AllowOrigins:     []string{"*"},
		AllowMethods:     []string{"PUT", "get", "POST", "DELETE"},
		AllowCredentials: true,
		MaxAge:           12 * time.Hour,
	}))

	cors.GET("/books", r.GetBooks)
	cors.GET("/books/:id", r.GetBook)
	cors.POST("/books", r.AddBook)
	cors.POST("/books/borrow/:id", r.BorrowBook)
	cors.DELETE("/books/:id", r.DeleteBook)
	cors.PUT("/books/:id", r.UpdateBook)
	cors.POST("/books/like/:id", r.LikeBook)
	cors.POST("/books/remove_like/:id", r.RemoveLike)

	cors.GET("/", func(ctx *gin.Context) {
		ctx.JSON(http.StatusOK, gin.H{"message": "Welcome to the Book API"})
	})

	doc := redoc.Redoc{
		Title:       "Api Documentation",
		Description: "Documentation for Book API",
		SpecFile:    "./swagger.yaml",
		SpecPath:    "/swagger.yaml",
		DocsPath:    "/books/docs",
	}

	cors.Use(ginredoc.New(doc))

}

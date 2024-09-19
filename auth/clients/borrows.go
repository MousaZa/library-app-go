package clients

import (
	"context"
	"fmt"
	"net/http"

	borrows "github.com/MousaZa/library-app-go/borrows/protos/borrows"
	"github.com/gin-gonic/gin"
)

type BorrowsClient struct {
	client borrows.BorrowsClient
}

func NewBorrowsClient(client borrows.BorrowsClient) *BorrowsClient {
	return &BorrowsClient{client: client}
}

func (c *BorrowsClient) AddBorrow(ctx *gin.Context) {
	ar := &borrows.AddBorrowRequest{}
	if err := ctx.ShouldBindJSON(ar); err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	_, err := c.client.AddBorrow(context.Background(), &borrows.AddBorrowRequest{BookId: ar.BookId, UserId: ar.UserId})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
}

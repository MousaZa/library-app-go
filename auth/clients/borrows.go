package clients

import (
	"context"

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
		return
	}
	_, err := c.client.AddBorrow(context.Background(), &borrows.AddBorrowRequest{BookId: ar.BookId, UserId: ar.UserId})
	if err != nil {
		ctx.JSON(500, gin.H{"error": err.Error()})
		return
	}
}

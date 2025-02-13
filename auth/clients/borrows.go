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

func (c *BorrowsClient) GetUserBorrows(ctx *gin.Context) {
	userId := ctx.MustGet("userId").(int64)

	resp, err := c.client.GetUserBorrows(context.Background(), &borrows.GetUserBorrowsRequest{UserId: userId})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, resp.Borrows)
}

func (c *BorrowsClient) GetUserOnGoingBorrows(ctx *gin.Context) {
	userId := ctx.MustGet("userId").(int64)
	// TODO FIX
	resp, err := c.client.GetUserOnGoingBorrows(context.Background(), &borrows.GetUserBorrowsRequest{UserId: userId})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, resp.Borrows)
}

func (c *BorrowsClient) GetAllBorrows(ctx *gin.Context) {
	resp, err := c.client.GetAllBorrows(context.Background(), &borrows.GetAllBorrowsRequest{})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, resp.Borrows)
}

func (c *BorrowsClient) GetOnGoingBorrows(ctx *gin.Context) {
	resp, err := c.client.GetOnGoingBorrows(context.Background(), &borrows.GetAllBorrowsRequest{})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, resp.Borrows)
}

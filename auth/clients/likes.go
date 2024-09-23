package clients

import (
	"context"
	"fmt"
	"net/http"
	"strconv"

	likes "github.com/MousaZa/library-app-go/likes/protos/likes"
	"github.com/gin-gonic/gin"
)

type LikesClient struct {
	client likes.LikesClient
}

func NewLikesClient(client likes.LikesClient) *LikesClient {
	return &LikesClient{client: client}
}

type LikeRequest struct {
	BookId int64 `json:"bookId"`
}

func (c *LikesClient) AddLike(ctx *gin.Context) {
	lr := &LikeRequest{}
	if err := ctx.ShouldBindJSON(lr); err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	userId := ctx.MustGet("userId").(int64)
	_, err := c.client.AddLike(context.Background(), &likes.LikeRequest{BookId: lr.BookId, UserId: userId})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
}

func (c *LikesClient) GetLike(ctx *gin.Context) {
	bookId, err := strconv.ParseInt(ctx.Param("id"), 10, 64)
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	userId := ctx.MustGet("userId").(int64)
	resp, err := c.client.GetLike(context.Background(), &likes.LikeRequest{BookId: bookId, UserId: userId})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	ctx.JSON(http.StatusOK, gin.H{"response": resp.Response})
}

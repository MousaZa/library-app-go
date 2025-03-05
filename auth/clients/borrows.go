package clients

import (
	"context"
	"fmt"
	"net/http"
	"strconv"

	"github.com/MousaZa/library-app-go/auth/models"
	borrows "github.com/MousaZa/library-app-go/borrows/protos/borrows"
	"github.com/gin-gonic/gin"
	"google.golang.org/protobuf/types/known/timestamppb"
	"gorm.io/gorm"
)

type BorrowsClient struct {
	client borrows.BorrowsClient
	db     *gorm.DB
}

func NewBorrowsClient(client borrows.BorrowsClient, db *gorm.DB) *BorrowsClient {
	return &BorrowsClient{client: client, db: db}
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

type userResponse struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	Email    string `json:"email"`
	Role     string `json:"role"`
}

type borrowResponse struct {
	ID         int64                  `json:"id"`
	BookId     int64                  `json:"book_id"`
	UserData   userResponse           `json:"user_data"`
	BorrowDate *timestamppb.Timestamp `json:"BorrowDate"`
	ReturnDate *timestamppb.Timestamp `json:"ReturnDate"`
	Status     string                 `json:"Status"`
}

func (c *BorrowsClient) GetOnGoingBorrows(ctx *gin.Context) {
	br, err := c.client.GetOnGoingBorrows(context.Background(), &borrows.GetAllBorrowsRequest{})
	if err != nil {
		fmt.Printf("Failed to bind JSON: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	resp := []borrowResponse{}
	for _, b := range br.Borrows {
		u := models.User{}

		err := c.db.Where("id = ?", strconv.FormatInt(b.UserId, 10)).First(&u).Error
		ur := userResponse{}

		if err != nil {
			ur = userResponse{
				ID:       "0",
				Username: "Deleted User",
				Email:    "Deleted User",
				Role:     "user",
			}
		} else {
			ur = userResponse{
				ID:       strconv.Itoa(int(u.ID)),
				Username: u.Username,
				Email:    u.Email,
				Role:     u.Role,
			}
		}

		resp = append(resp, borrowResponse{
			ID:         b.Id,
			BookId:     b.BookId,
			UserData:   ur,
			BorrowDate: b.BorrowDate,
			ReturnDate: b.ReturnDate,
			Status:     b.Status,
		})
	}
	ctx.JSON(http.StatusOK, resp)
}

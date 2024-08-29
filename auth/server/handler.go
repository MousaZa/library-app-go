package server

import (
	"net/http"
	"strconv"
	"time"

	"github.com/MousaZa/library-app-go/auth/models"
	"github.com/MousaZa/library-app-go/auth/token"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

var users []models.User

type loginRequest struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type loginResponse struct {
	AccessToken string      `json:"access_token"`
	User        models.User `json:"user"`
}

func (server *Server) login(ctx *gin.Context) {
	// Request binding for login credentials
	var req loginRequest
	if err := ctx.ShouldBindJSON(&req); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}
	user := models.User{}
	// err := server.db.Find(&users).Error
	err := server.db.Where("username = ?", req.Username).First(&user).Error
	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "User not found\n"})
		return
	}
	err = token.CheckPassword(req.Password, user.Password)
	if err != nil {
		ctx.JSON(http.StatusForbidden, gin.H{"error": "Incorrect password\n"})
		return
	}
	// Create and send an access token
	accessToken, err := server.tokenMaker.CreateToken(req.Username, time.Minute)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error() + "\n"})
		return
	}

	// Respond with login details
	rsp := loginResponse{
		AccessToken: accessToken,
		User:        user,
	}
	ctx.JSON(http.StatusOK, rsp)

}

func (server *Server) createUser(ctx *gin.Context) {
	// Request binding for new user details
	var user models.User
	if err := ctx.ShouldBindJSON(&user); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}

	// Assign a unique ID and add the user to the list
	id, err := uuid.NewRandom()
	user.ID = strconv.Itoa(int(id.ID()))
	hashedPass, err := token.HashPassword(user.Password)
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to hash password\n"})
	}
	user.Password = hashedPass
	err = server.db.Create(&user).Error
	if err != nil {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to create user\n"})
	}

	// Respond with the updated user list
	ctx.JSON(http.StatusOK, users)
}

type deleteUserRequet struct {
	ID string `uri:"id" binding:"required"`
}

func (server *Server) deleteUser(ctx *gin.Context) {
	// Request binding for user ID
	id := ctx.Param("id")

	err := server.db.Delete(&models.User{}, id).Error
	if err != nil {
		ctx.JSON(http.StatusNotFound, "User not found\n")
	}
	ctx.JSON(http.StatusOK, "User deleted successfully\n")
	// Find and delete the user from the list

	// Respond with user list if the user is not found

}

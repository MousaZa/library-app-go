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
		server.l.Error("Failed to bind JSON", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}
	user := models.User{}
	// err := server.db.Find(&users).Error
	err := server.db.Where("username = ?", req.Username).First(&user).Error
	if err != nil {
		server.l.Error("Failed to find user", err)
		ctx.JSON(http.StatusNotFound, gin.H{"error": "User not found\n"})
		return
	}
	err = token.CheckPassword(req.Password, user.Password)
	if err != nil {
		server.l.Error("Incorrect password", err)
		ctx.JSON(http.StatusForbidden, gin.H{"error": "Incorrect password\n"})
		return
	}
	// Create and send an access token
	accessToken, err := server.tokenMaker.CreateToken(req.Username, time.Minute)
	if err != nil {
		server.l.Error("Failed to create access token", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error() + "\n"})
		return
	}

	// Respond with login details
	rsp := loginResponse{
		AccessToken: accessToken,
		User:        user,
	}
	server.l.Info("User logged in", "username", req.Username)
	ctx.JSON(http.StatusOK, rsp)

}

func (server *Server) createUser(ctx *gin.Context) {
	// Request binding for new user details
	var user models.User
	if err := ctx.ShouldBindJSON(&user); err != nil {
		server.l.Error("Failed to bind JSON", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}

	// Assign a unique ID and add the user to the list
	id, err := uuid.NewRandom()
	user.ID = strconv.Itoa(int(id.ID()))
	hashedPass, err := token.HashPassword(user.Password)
	if err != nil {
		server.l.Error("Failed to hash password", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to hash password\n"})
	}
	user.Password = hashedPass
	err = server.db.Create(&user).Error
	if err != nil {
		server.l.Error("Failed to create user", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to create user\n"})
	}

	// Respond with the updated user list
	server.l.Info("User created", "username", user.Username)
	ctx.JSON(http.StatusOK, users)
}

func (server *Server) deleteUser(ctx *gin.Context) {
	// Request binding for user ID
	id := ctx.Param("id")

	err := server.db.Delete(&models.User{}, id).Error
	if err != nil {
		server.l.Error("Failed to delete user", err)
		ctx.JSON(http.StatusNotFound, "User not found\n")
	}
	server.l.Info("User deleted", "id", id)
	ctx.JSON(http.StatusOK, "User deleted successfully\n")

}

// Package classification of Auth API
//
// Documentation for Auth API
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
package server

import (
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/MousaZa/library-app-go/auth/models"
	"github.com/MousaZa/library-app-go/auth/token"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"gorm.io/gorm"
)

var users []models.User

// The Login Requset
// swagger:parameters login
type loginRequest struct {
	// username
	// in: body
	// required: true
	Username string `json:"username" binding:"required"`
	// password
	// in: body
	// required: true
	Password string `json:"password" binding:"required"`
}

// A token is returned in the response
// swagger:response loginResponse
type loginResponse struct {
	// access token
	// in: body
	AccessToken string `json:"access_token"`
}

// The user data is returned in the response
// swagger:response usersResponse
type UserResponse struct {
	// user id
	// in: body
	ID string `json:"user_id"`
	// username
	// in: body
	Username string `json:"username"`
	// email
	// in: body
	Email string `json:"email"`
	// role
	// in: body
	Role string `json:"role"`
}

// A list of user data is returned in the response
// swagger:response usersResponse
type UsersResponse struct {
	body []UserResponse
}

// swagger:route GET /auth/list/users auth ListUsers
// responses:
//
//	200: usersResponse

// ListUsers lists all the users in the database
func (server *Server) ListUsers(ctx *gin.Context) {
	users := &[]models.User{}
	err := server.db.Find(&users).Error
	if err != nil {
		// server.l.Error("Failed to list books", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to list users\n"})
	}
	ctx.JSON(http.StatusOK, users)
}

// swagger:route GET /auth/user auth getUserData
// responses:
//
//	200: userResponse

// Gets the data of a specific user
func (server *Server) getUserData(ctx *gin.Context) {
	authHeader := ctx.GetHeader(authorizationHeaderKey)
	token := strings.Fields(authHeader)[1]
	payload, err := server.tokenMaker.VerifyToken(token)
	if err != nil {
		// server.l.Error("Failed to verify token", err)
		ctx.JSON(http.StatusUnauthorized, gin.H{"error": "Access Token Not Valid\n"})
		return
	}

	resp := &UserResponse{}
	json.Unmarshal(payload, resp)
	ctx.JSON(http.StatusOK, resp)
}

// swagger:route POST /auth/login auth login
// responses:
//
//	200: loginResponse

// Returns an Access Token if the credintials are true
func (server *Server) login(ctx *gin.Context) {

	var req loginRequest
	if err := ctx.ShouldBindJSON(&req); err != nil {
		// server.l.Error("Failed to bind JSON", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}
	user := models.User{}

	err := server.db.Where("username = ?", req.Username).First(&user).Error
	if err != nil {
		// server.l.Error("Failed to find user", err)
		ctx.JSON(http.StatusNotFound, gin.H{"error": "User not found\n"})
		return
	}
	err = token.CheckPassword(req.Password, user.Password)
	if err != nil {
		// server.l.Error("Incorrect password", err)
		ctx.JSON(http.StatusForbidden, gin.H{"error": "Incorrect password\n"})
		return
	}

	payload, err := token.NewPayload(user.Username, user.Role, user.Email, user.ID, time.Hour*2)
	if err != nil {
		// server.l.Error("Failed to create payload", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to create payload\n"})
		return
	}
	accessToken, err := server.tokenMaker.CreateToken(payload)
	if err != nil {
		// server.l.Error("Failed to create access token", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": err.Error() + "\n"})
		return
	}

	rsp := loginResponse{
		AccessToken: accessToken,
	}

	ctx.JSON(http.StatusOK, rsp)

}

// swagger:response noContent
type authNoContent struct {
}

// swagger:route POST /auth/create auth createUser
// responses:
//
//	201: noContent

// Creates a new user - doesn't return anything
func (server *Server) createUser(ctx *gin.Context) {

	var user models.User
	if err := ctx.ShouldBindJSON(&user); err != nil {
		// server.l.Error("Failed to bind JSON", err)
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}
	user.Role = "user"
	// Check if username already exists
	var existingUser models.User
	if err := server.db.Where("username = ?", user.Username).First(&existingUser).Error; err == nil {
		ctx.JSON(http.StatusConflict, gin.H{"error": "Username already exists\n"})
		return
	} else if !errors.Is(err, gorm.ErrRecordNotFound) {
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to check username\n"})
		return
	}

	id, _ := uuid.NewRandom()
	user.ID = int64(id.ID())
	hashedPass, err := token.HashPassword(user.Password)
	if err != nil {
		// server.l.Error("Failed to hash password", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to hash password\n"})
		return
	}
	user.Password = hashedPass
	user.CanBorrow = true
	err = server.db.Create(&user).Error
	if err != nil {
		// server.l.Error("Failed to create user", err)
		fmt.Printf("Failed to create user: %v\n", err)
		ctx.JSON(http.StatusInternalServerError, gin.H{"error": "Unable to create user\n"})
		return
	}
	ctx.JSON(http.StatusOK, users)
}

// swagger:route POST /auth/delete/{id} auth deleteUser
// responses:
//
//	201: noContent

// Deletes a user - doesn't return anything
func (server *Server) deleteUser(ctx *gin.Context) {
	// Request binding for user ID
	id := ctx.Param("id")

	err := server.db.Delete(&models.User{}, id).Error
	if err != nil {
		// server.l.Error("Failed to delete user", err)
		ctx.JSON(http.StatusNotFound, "User not found\n")
	}
	// server.l.Info("User deleted", "id", id)
	ctx.JSON(http.StatusOK, "User deleted successfully\n")

}

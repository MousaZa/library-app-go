package server

import (
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"golang.org/x/exp/rand"
)

type User struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	Email    string `json:"email"`
	Password string `json:"password"`
}

var users []User

type loginRequest struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type loginResponse struct {
	AccessToken string `json:"access_token"`
	User        User   `json:"user"`
}

func (server *Server) login(ctx *gin.Context) {
	// Request binding for login credentials
	var req loginRequest
	if err := ctx.ShouldBindJSON(&req); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}

	// Validate credentials and generate an access token
	for _, user := range users {
		if user.Username == req.Username {
			if user.Password == req.Password {
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
				return
			}
			ctx.JSON(http.StatusForbidden, gin.H{"error": "Incorrect password\n"})
			return
		}
	}
	ctx.JSON(http.StatusNotFound, users)
}

// type createUserRequest struct {
// 	Username string `json:"username" binding:"required"`
// 	Email    string `json:"email" binding:"required"`
// 	Password string `json:"password" binding:"required"`
// }

func (server *Server) createUser(ctx *gin.Context) {
	// Request binding for new user details
	var user User
	if err := ctx.ShouldBindJSON(&user); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}

	// Assign a unique ID and add the user to the list
	user.ID = strconv.Itoa(rand.Intn(1000))
	users = append(users, user)

	// Respond with the updated user list
	ctx.JSON(http.StatusOK, users)
}

type deleteUserRequet struct {
	ID string `uri:"id" binding:"required"`
}

func (server *Server) deleteUser(ctx *gin.Context) {
	// Request binding for user ID
	var req deleteUserRequet
	if err := ctx.ShouldBindUri(&req); err != nil {
		ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error() + "\n"})
		return
	}

	// Find and delete the user from the list
	for idx, user := range users {
		if user.ID == req.ID {
			users = append(users[:idx], users[idx+1:]...)
			ctx.JSON(http.StatusOK, users)
			return
		}
	}

	// Respond with user list if the user is not found
	ctx.JSON(http.StatusNotFound, users)
}

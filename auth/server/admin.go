package server

import (
	"net/http"
	"strconv"

	"github.com/MousaZa/library-app-go/auth/models"
	"github.com/gin-gonic/gin"
)

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

// swagger:route GET /auth/user/{id} auth getUserDataById
// responses:
//
//	200: userResponse

// Gets the data of a specific user using the user id
func (server *Server) getUserDataById(ctx *gin.Context) {
	id := ctx.Param("id")
	user := &models.User{}

	err := server.db.Where("id = ?", id).First(user).Error

	if err != nil {
		ctx.JSON(http.StatusNotFound, gin.H{"error": "User not found\n"})
		return
	}

	resp := &userResponse{}

	resp.ID = strconv.Itoa(int(user.ID))
	resp.Username = user.Username
	resp.Email = user.Email
	resp.Role = user.Role

	ctx.JSON(http.StatusOK, resp)
}

// Package classification of Images API
//
// Documentation for Images API
//
//	Schemes: http
//	BasePath: /
//	Version: 1.0.0
//
// Consumes:
// - application/json
// - image/png
// - image/jpeg
// - image/jpg
//
// Produces:
// - application/json
// - image/png
// - image/jpeg
// - image/jpg
//
// swagger:meta
package server

import (
	"fmt"
	"io"
	"os"
	"path/filepath"
	"strings"

	"github.com/gin-contrib/gzip"
	"github.com/gin-gonic/gin"
)

func SetupRoutes(router *gin.Engine) {
	router.Use(gzip.Gzip(gzip.DefaultCompression))
	router.POST("/images/covers/:id", UploadBookCover)
	router.POST("/images/avatars/:id", UploadUserAvatar)
	router.GET("/images/covers/:id", GetBookCover)
	router.GET("/images/avatars/:id", GetUserAvatar)
	router.DELETE("/images/covers/:id", DeleteBookCover)
	router.DELETE("/images/avatars/:id", DeleteUserAvatar)
}

// swagger:response noContent
type imagesNoContent struct {
}

// swagger:route POST /images/covers/{id} users uploadBookCover
//
// responses:
//
//	201: noContent
//	500: noContent
//	400: noContent
//
// UploadBookCover uploads a book cover image.
func UploadBookCover(c *gin.Context) {
	id := c.Param("id")
	file, header, err := c.Request.FormFile("upload")
	if err != nil {
		fmt.Printf("err:%v", err)
		c.JSON(500, gin.H{})
	}
	fmt.Println(header.Filename)
	if !isImageFile(header.Filename) {
		c.JSON(400, "invalid file type")
		return
	}
	if _, err := os.Stat("/app/images/covers/"); os.IsNotExist(err) {
		err = os.MkdirAll("/app/images/covers/", os.ModePerm)
		if err != nil {
			fmt.Printf("err:%v", err)
			c.JSON(500, gin.H{})
		}
	}
	ext := strings.ToLower(filepath.Ext(header.Filename))
	out, err := os.Create("/app/images/covers/" + id + ext)
	if err != nil {
		fmt.Printf("err:%v", err)
		c.JSON(500, gin.H{})
	}
	defer out.Close()
	_, err = io.Copy(out, file)
	if err != nil {
		fmt.Printf("err:%v", err)
		c.JSON(500, "upload failed")
	}
}

// swagger:route GET /images/covers/{id} users getBookCover
//
// responses:
//
//	200: {string} string "image file"
//	404: noContent
//
// GetBookCover gets a book cover image.
func GetBookCover(c *gin.Context) {
	id := c.Param("id")
	pattern := "/app/images/covers/" + id + ".*"
	matches, err := filepath.Glob(pattern)
	if err != nil || len(matches) == 0 {
		c.String(404, "File not found")
		return
	}
	c.File(matches[0])
}

func DeleteBookCover(c *gin.Context) {
	id := c.Param("id")
	pattern := "/app/images/covers/" + id + ".*"
	matches, err := filepath.Glob(pattern)
	if err != nil || len(matches) == 0 {
		c.String(404, "File not found")
		return
	}
	err = os.Remove(matches[0])
	if err != nil {
		c.String(500, "Unable to delete file")
		return
	}
	c.String(200, "File deleted")
}

func DeleteUserAvatar(c *gin.Context) {
	id := c.Param("id")
	pattern := "/app/images/avatars/" + id + ".*"
	matches, err := filepath.Glob(pattern)
	if err != nil || len(matches) == 0 {
		c.String(404, "File not found")
		return
	}
	err = os.Remove(matches[0])
	if err != nil {
		c.String(500, "Unable to delete file")
		return
	}
	c.String(200, "File deleted")
}

// swagger:route POST /images/avatars/{id} users uploadUserAvatar
//
// responses:
//
//	201: noContent
//	500: noContent
//	400: noContent
//
// UploadUserAvatar uploads a user avatar image.
func UploadUserAvatar(c *gin.Context) {
	id := c.Param("id")
	file, header, err := c.Request.FormFile("upload")
	if err != nil {
		fmt.Printf("err:%v", err)
		c.JSON(500, "bad request")
	}
	fmt.Println(header.Filename)
	if !isImageFile(header.Filename) {
		c.JSON(400, "invalid file type")
		return
	}
	if _, err := os.Stat("/app/images/avatars/"); os.IsNotExist(err) {
		err = os.MkdirAll("/app/images/avatars/", os.ModePerm)
		if err != nil {
			fmt.Printf("err:%v", err)
			c.JSON(500, gin.H{})
		}
	}
	ext := strings.ToLower(filepath.Ext(header.Filename))
	out, err := os.Create("/app/images/avatars/" + id + ext)
	if err != nil {
		fmt.Printf("err:%v", err)
		c.JSON(500, gin.H{})
	}
	defer out.Close()
	_, err = io.Copy(out, file)
	if err != nil {
		fmt.Printf("err:%v", err)
		c.JSON(500, "upload failed")
	}
}

// swagger:route GET /images/avatars/{id} users getUserAvatar
//
// responses:
//
//	200: {string} string "image file"
//	404: noContent
//
// GetUserAvatar gets a user avatar image.
func GetUserAvatar(c *gin.Context) {
	id := c.Param("id")
	pattern := "/app/images/avatars/" + id + ".*"
	matches, err := filepath.Glob(pattern)
	if err != nil || len(matches) == 0 {
		c.String(404, "File not found")
		return
	}
	c.File(matches[0])
}

func isImageFile(fileName string) bool {
	ext := strings.ToLower(filepath.Ext(fileName))
	return ext == ".jpg" || ext == ".jpeg" || ext == ".png"
}

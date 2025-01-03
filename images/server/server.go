// Package classification of Images API
//
// Documentation for Images API
//
//	Schemes: http
//	BasePath: /
//	Version: 1.0.0
//
//	Consumes:
//	- image/jpeg
//
//	Produces:
//	- image/jpeg
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
}

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
	ext := strings.ToLower(filepath.Ext(header.Filename))
	out, err := os.Create("./storage/covers/" + id + ext)
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

func GetBookCover(c *gin.Context) {
	id := c.Param("id")
	pattern := "./storage/covers/" + id + ".*"
	matches, err := filepath.Glob(pattern)
	if err != nil || len(matches) == 0 {
		c.String(404, "File not found")
		return
	}
	c.File(matches[0])
}

func UploadUserAvatar(c *gin.Context) {
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
	ext := strings.ToLower(filepath.Ext(header.Filename))
	out, err := os.Create("./storage/avatars/" + id + ext)
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

func GetUserAvatar(c *gin.Context) {
	id := c.Param("id")
	pattern := "./storage/avatars/" + id + ".*"
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

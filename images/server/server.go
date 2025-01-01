package server

import (
	"fmt"
	"io"
	"os"

	"github.com/gin-gonic/gin"
)

func SetupRoutes(router *gin.Engine) {
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
	out, err := os.Create("./storage/covers/" + id + ".jpg")
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
	c.File("./storage/covers/" + id + ".jpg")
}

func UploadUserAvatar(c *gin.Context) {
	id := c.Param("id")
	file, header, err := c.Request.FormFile("upload")
	if err != nil {
		fmt.Printf("err:%v", err)
		c.JSON(500, gin.H{})
	}
	fmt.Println(header.Filename)
	out, err := os.Create("./storage/avatars/" + id + ".jpg")
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
	c.File("./storage/avatars/" + id + ".jpg")
}

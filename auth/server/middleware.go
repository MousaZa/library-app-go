package server

import (
	"net/http"
	"strings"

	"github.com/MousaZa/library-app-go/auth/token"
	"github.com/gin-gonic/gin"
)

const (
	authorizationHeaderKey        = "Authorization"
	authorizationHeaderBearerType = "bearer"
)

func AuthMiddleware(maker token.PasetoMaker) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		authHeader := ctx.GetHeader(authorizationHeaderKey)
		if authHeader == "" {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "No header was passed\n"})
			return
		}

		fields := strings.Fields(authHeader)
		if len(fields) != 2 {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Invalid or Missing Bearer Token\n"})
			return
		}

		authType := fields[0]
		if strings.ToLower(authType) != authorizationHeaderBearerType {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Authorization Type Not Supported\n"})
			return
		}

		token := fields[1]
		_, err := maker.VerifyToken(token)
		if err != nil {
			ctx.AbortWithStatusJSON(http.StatusUnauthorized, gin.H{"error": "Access Token Not Valid\n"})
			return
		}

		ctx.Next()
	}
}
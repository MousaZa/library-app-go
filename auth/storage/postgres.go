package storage

import (
	"fmt"
	"io/ioutil"

	"github.com/MousaZa/library-app-go/auth/models"
	"github.com/hashicorp/go-hclog"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type Config struct {
	Host     string
	Port     string
	User     string
	Password string
	DBName   string
	SSLMode  string
}

func NewConnection(cfg *Config) (*gorm.DB, error) {

	bin, err := ioutil.ReadFile("/run/secrets/db-password")
	if err != nil {
		return nil, fmt.Errorf("failed to read database password: %w", err)
	}

	// Build connection string with SSL mode disabled
	dsn := fmt.Sprintf("host=db user=postgres password=%s dbname=library port=5432 sslmode=disable TimeZone=Asia/Shanghai", string(bin)) // Adjust TimeZone as needed

	// Open connection using GORM
	config := &gorm.Config{}
	return gorm.Open(postgres.Open(dsn), config)

}

type Database struct {
	db *gorm.DB
	l  hclog.Logger
}

func (db *Database) Migrate() {
	err := db.db.AutoMigrate(&models.User{})
	if err != nil {
		db.l.Error("Unable to migrate books", "error", err)
		return
	}
	db.l.Info("Users migrated successfully")

}

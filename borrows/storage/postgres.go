package storage

import (
	"github.com/MousaZa/library-app-go/borrows/models"
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
	dsn := "user=" + cfg.User + " password=" + cfg.Password + " dbname=" + cfg.DBName + " port=" + cfg.Port + " sslmode=" + cfg.SSLMode + " TimeZone=Asia/Shanghai"
	return gorm.Open(postgres.Open(dsn), &gorm.Config{})
}

type Database struct {
	db *gorm.DB
	l  hclog.Logger
}

func (db *Database) Migrate() {
	err := db.db.AutoMigrate(&models.Borrow{})
	if err != nil {
		db.l.Error("Unable to migrate books", "error", err)
		return
	}
	db.l.Info("Books migrated successfully")

}

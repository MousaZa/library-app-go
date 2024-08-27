package storage

import (
	"github.com/MousaZa/library-app-go/books/models"
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

func NewDatabase() Database {
	dsn := "host=localhost user=dev password=strongone dbname=books port=5432 sslmode=disable TimeZone=Asia/Shanghai"
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	l := hclog.Default()
	l.Info("Connected to database")
	return Database{db: db, l: l}
}

func (db *Database) Migrate() {
	db.db.AutoMigrate(&models.Book{})
}

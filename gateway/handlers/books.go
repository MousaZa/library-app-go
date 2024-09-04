package handlers

import (
	"github.com/hashicorp/go-hclog"
)

type Books struct {
	l hclog.Logger
}

func NewBooks(l hclog.Logger) *Books {
	return &Books{l: l}
}

func (b *Books) AddBook() {

}

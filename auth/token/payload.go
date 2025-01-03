package token

import (
	"time"

	"github.com/google/uuid"
)

type Payload struct {
	ID        uuid.UUID `json:"payload_id"`
	UserId    int64     `json:"id"`
	Email     string    `json:"email"`
	Username  string    `json:"username"`
	Role      string    `json:"role"`
	CreatedAt time.Time `json:"created_at"`
	ExpiryAt  time.Time `json:"expiry_at"`
}

func NewPayload(username, role, email string, userId int64, duration time.Duration) (*Payload, error) {
	tokenId, err := uuid.NewRandom()
	if err != nil {
		return nil, err
	}

	payload := &Payload{
		ID:        tokenId,
		Username:  username,
		UserId:    userId,
		Email:     email,
		Role:      role,
		CreatedAt: time.Now(),
		ExpiryAt:  time.Now().Add(duration),
	}

	return payload, nil
}

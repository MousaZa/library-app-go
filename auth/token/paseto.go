package token

import (
	"fmt"
	"time"

	"aidanwoods.dev/go-paseto"
	"github.com/aead/chacha20poly1305"
)

type PasetoMaker struct {
	publicKey paseto.V4AsymmetricPublicKey
	secretKey paseto.V4AsymmetricSecretKey
}

func NewPaseto(symmetricKey string) (*PasetoMaker, error) {
	secretKey := paseto.NewV4AsymmetricSecretKey()
	publicKey := secretKey.Public()

	if len(symmetricKey) != chacha20poly1305.KeySize {
		return nil, fmt.Errorf("SymmetricKey too short should be: %v\n", chacha20poly1305.KeySize)
	}

	maker := &PasetoMaker{
		publicKey: publicKey,
		secretKey: secretKey,
	}

	return maker, nil
}

func (maker *PasetoMaker) CreateToken(payload *Payload) (string, error) {
	// payload, err := NewPayload(username)
	// if err != nil {
	// 	return "", err
	// }
	token := paseto.NewToken()

	token.SetIssuedAt(time.Now())
	token.SetNotBefore(time.Now())
	token.SetExpiration(time.Now().Add(2 * time.Hour))

	token.SetString("id", fmt.Sprintf("%d", payload.UserId))
	token.SetString("username", payload.Username)
	token.SetString("email", payload.Email)

	// don't share this!!!

	signed := token.V4Sign(maker.secretKey, nil)

	return signed, nil
}

func (maker *PasetoMaker) VerifyToken(signed string) ([]byte, error) {

	parser := paseto.NewParser()
	token, err := parser.ParseV4Public(maker.publicKey, signed, nil) // this will fail if parsing failes, cryptographic checks fail, or validation rules fail

	// err := maker.paseto.Decrypt(token, maker.symmetricKey, payload, nil)
	if err != nil {
		return nil, err
	}
	fmt.Printf("data: %s\n", token.ClaimsJSON())

	return token.ClaimsJSON(), nil
}

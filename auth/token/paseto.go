package token

import (
	"fmt"
	"time"

	"aidanwoods.dev/go-paseto"
)

type PasetoMaker struct {
	publicKey paseto.V4AsymmetricPublicKey
	secretKey paseto.V4AsymmetricSecretKey
}

func NewPaseto(symmetricKey string) (*PasetoMaker, error) {
	secretKey := paseto.NewV4AsymmetricSecretKey()
	publicKey := secretKey.Public()

	maker := &PasetoMaker{
		publicKey: publicKey,
		secretKey: secretKey,
	}

	return maker, nil
}

func (maker *PasetoMaker) CreateToken(payload *Payload) (string, error) {

	token := paseto.NewToken()

	token.SetIssuedAt(time.Now())
	token.SetNotBefore(time.Now())
	token.SetExpiration(time.Now().Add(2 * time.Hour))

	token.SetString("user_id", fmt.Sprintf("%d", payload.UserId))
	token.SetString("username", payload.Username)
	token.SetString("email", payload.Email)

	signed := token.V4Sign(maker.secretKey, nil)

	return signed, nil
}

func (maker *PasetoMaker) VerifyToken(signed string) ([]byte, error) {

	parser := paseto.NewParser()
	token, err := parser.ParseV4Public(maker.publicKey, signed, nil)

	if err != nil {
		return nil, err
	}
	fmt.Printf("data: %s\n", token.ClaimsJSON())

	return token.ClaimsJSON(), nil
}

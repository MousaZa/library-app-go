check_install:
	which swagger || go install github.com/go-swagger/go-swagger/cmd/swagger@latest

swagger:
	swagger generate spec -o .\swagger.yaml --scan-models

.PHONY: protos

protos:
	protoc -I protos/ protos/books.proto --go_out=plugins=grpc:protos/books
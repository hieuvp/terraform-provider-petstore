#!/usr/bin/env bash

set -eoux pipefail

(
  cd scripts
  chmod +x ./*.sh
  shfmt -i 2 -ci -sr -bn -s -w ./*.sh
)

(
  prettier --write README.md
  prettier --write ./*.yml
  prettier --write ./.github/**/*.yml
)

(
  go mod tidy
  go fmt main.go

  cd petstore
  go fmt ./...
)

(
  cd sdk

  go mod tidy
  go fmt ./...

  prettier --write README.md

  prettier --write openapi.md
  prettier --write openapi.yaml
)

(
  cd example/api
  terraform fmt
)

(
  cd example/petstore
  terraform fmt
)

(
  cd example/modules/petstore
  terraform fmt
)

(
  cd example/modules/petstore/modules/apigw
  terraform fmt
)

(
  cd example/modules/petstore/modules/database
  terraform fmt
)

(
  cd example/modules/petstore/modules/lambda
  terraform fmt
)

(
  cd example/modules/petstore/modules/networking
  terraform fmt
)

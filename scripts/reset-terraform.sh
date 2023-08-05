#!/usr/bin/env bash

set -eoux pipefail

(
  cd example/api

  trash .terraform .terraform.lock.hcl
  terraform init
)

(
  cd example/petstore

  trash .terraform .terraform.lock.hcl
  terraform init
)

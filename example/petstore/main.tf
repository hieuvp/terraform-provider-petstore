terraform {
  required_providers {
    petstore = {
      source  = "github.com/hieuvp/petstore"
      version = "~> 1.0.0"
    }
  }
}

data "terraform_remote_state" "api" {
  backend = "local"
  config = {
    path = "../api/terraform.tfstate"
  }
}

provider "petstore" {
  address = data.terraform_remote_state.api.outputs.address
}

resource "petstore_pet" "pet" {
  name    = "snowball"
  species = "cat"
  age     = 20
}

output "address" {
  value = data.terraform_remote_state.api.outputs.address
}

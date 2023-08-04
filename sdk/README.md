# Petstore Go Client

This is an API client for [Petstore](https://github.com/scottwinkler/manning-code).

## Installation

Installation can be done with a normal `go get`:

```
go get -u github.com/hieuvp/terraform-provider-petstore/sdk
```

## Documentation

For complete usage of the API client, see the full [package docs](https://godoc.org/github.com/hieuvp/terraform-provider-petstore/sdk).

## Usage

```go
import sdk "github.com/hieuvp/terraform-provider-petstore/sdk"
```

Construct a new Petstore client, then use the various endpoints on the client to
access different parts of the Petstore API. For example, to list
all pets:

```go
config := &sdk.Config{
	Address: "insert-your-petstore-address-here",
}

client, err := sdk.NewClient(config)
if err != nil {
	log.Fatal(err)
}

orgs, err := client.Pets.List(PetListOptions{})
if err != nil {
	log.Fatal(err)
}
```

## Examples

The [examples](https://github.com/hieuvp/terraform-provider-petstore/tree/main/sdk/examples) directory
contains a couple of examples. One of which is listed here as well:

```go
package main

import (
	"log"

	sdk "github.com/hieuvp/terraform-provider-petstore/sdk"
)

func main() {
	config := &sdk.Config{
		Address: "insert-your-petstore-address-here",
	}

	client, err := sdk.NewClient(config)
	if err != nil {
		log.Fatal(err)
	}

	// Create a new pet
	options := sdk.PetCreateOptions{
        Name:  "mittens",
        Species: "cat",
        Age: 2,
	}

	pet, err := client.Pets.Create(options)
	if err != nil {
		log.Fatal(err)
	}

	// Delete a pet
	err = client.Pets.Delete(pet.ID)
	if err != nil {
		log.Fatal(err)
	}
}
```

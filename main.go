package main

import (
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
	"github.com/hieuvp/terraform-provider-petstore/petstore"
)

func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: petstore.Provider})
}

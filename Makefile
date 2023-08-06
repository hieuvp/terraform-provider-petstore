.PHONY: fmt
fmt:
	scripts/fmt.sh

.PHONY: provision
provision:
	cd example/api && terraform apply
	cd example/petstore && terraform apply

.PHONY: terminate
terminate:
	cd example/petstore && terraform destroy
	cd example/api && terraform destroy
	scripts/init-terraform.sh

.PHONY: build
build:
	trash terraform-provider-petstore
	env GOOS=darwin GOARCH=amd64 go build -o terraform-provider-petstore
	chmod +x terraform-provider-petstore
	trash ~/.terraform.d/plugins/github.com/hieuvp/petstore
	mkdir -p ~/.terraform.d/plugins/github.com/hieuvp/petstore/1.0.0/darwin_amd64
	mv terraform-provider-petstore ~/.terraform.d/plugins/github.com/hieuvp/petstore/1.0.0/darwin_amd64
	scripts/init-terraform.sh

.PHONY: test
test:
	cd petstore && TF_ACC=1 go test ./... -v

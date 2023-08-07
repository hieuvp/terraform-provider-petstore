variable "account_id" {
  description = "Your AWS account ID to setup the environment"
}

variable "region" {
  description = "The region to host the Petstore API in"
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

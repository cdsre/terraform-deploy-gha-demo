terraform {
  required_version = ">1.11.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
  
  backend "s3" {
    bucket = "cdsre-terraform-state"
    key = "gha-demo"
    region = "eu-west-2"
    
    
  }
}

variable "min" {
  type    = number
  default = 1
  validation {
    condition     = var.min >= 1
    error_message = "The min variable must be greater than or equal to 1."
  }
}

variable "max" {
  type    = number
  default = 3
  validation {
    condition     = var.max <= 7
    error_message = "The max variable must be less than or equal to 7."
  }
}

resource "random_integer" "foo" {
  max = var.max
  min = var.min
}

resource "random_pet" "bar" {
  length = random_integer.foo.result
  prefix = "helloworld"
}

output "name" {
  value = random_pet.bar.id
}

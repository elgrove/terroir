provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_dynamodb_table" "dynamo-table" {
  name           = "dynamo-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

}

resource "aws_vpc" "private_vpc" {
  cidr_block = "10.0.0.0/16"
}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

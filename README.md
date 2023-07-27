# AWS Chalice + Terraform

This repo is an example of a really cool AWS architectural pattern that uses their open source Python framework, [Chalice](https://github.com/aws/chalice), in conjunction with Terraform to provide a platform for very fast application development.

## How it works

- Write application code in Python
- With one simple decorator create a Lambda and all of the resources it requires, including API Gateway and IAM roles
- Chalice generates the Terraform for the resources it manages
- Write additional resources in Terraform, in this example a DynamoDB table
- Deploy all resources to AWS with a single command, `make deploy`

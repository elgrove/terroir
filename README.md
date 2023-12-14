# Terroir

An AWS pattern for super fast app development, using the AWS' open source Python framework, [Chalice](https://github.com/aws/chalice), in conjunction with Terraform.

## How it works

- Write application code in Python
- Use a Chalice decorator to create a Lambda and all of the resources it requires, including API Gateway and IAM roles
- At build and deploy time, Chalice generates the Terraform for the resources it manages
- Write additional resources that Chalice does not manage in Terraform (in this example, a DynamoDB table)
- Deploy all resources to AWS with a single command, `make deploy`

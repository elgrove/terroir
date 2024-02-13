# Terroir

An AWS pattern for super fast app development, combining the speed of AWS Chalice and the full array of AWS resources that can be declared in Terraform.

## How it works

Write application code in Python, using a Chalice decorator to create a Lambda and all of the resources it requires, including API Gateway and IAM roles


```python
@app.route("/item/{id}", methods=["GET"])
def get_item(id):
    """API Endpoint back by a Lambda, returns a DynamoDB table item."""
    table = boto3.resource("dynamodb").Table(os.environ["TABLE_NAME"])
    response = table.get_item(Key={"id": id})
    if item := response.get("Item"):
        return json.dumps(item)
    else:
        raise NotFoundError
```


Write additional resources that Chalice does not manage in Terraform (in this example, a DynamoDB table)

```hcl
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
```

At build and deploy time, Chalice generates the Terraform for the resources it manages

```shell
chalice package --pkg-format terraform ../infra/
```

Terraform can then deploy all resources, generated with Chalice or written in Hcl, to AWS with a single command

```shell
make deploy
```

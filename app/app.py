"""Simple Chalice app demonstrating the chalice-terraform pattern."""
import json
import os

import boto3
from chalice import Chalice, NotFoundError


app = Chalice(app_name="chalice-terraform")


@app.route("/item/{id}", methods=["GET"])
def get_item(id):
    """API Endpoint back by a Lambda, returns a DynamoDB table item."""
    table = boto3.resource("dynamodb").Table(os.environ["TABLE_NAME"])
    response = table.get_item(Key={"id": id})
    if item := response.get("Item"):
        return json.dumps(item)
    else:
        raise NotFoundError

import boto3

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    # Query the current count of resume hits
    # Assign it to hitCounter
    table = dynamodb.Table('cloud-resume-challenge-tf')
    response = table.get_item(
        Key={
            'id': '1'
        },
    )
    hitCountNumber = int(response['Item']['item_count'])

    hitCountNumber += 1
    hitCount = str(hitCountNumber)
    # Update the table with the number of hits
    response = table.update_item(
        Key={'id': '1'},
        UpdateExpression="SET item_count= :s",
        ExpressionAttributeValues={':s': hitCount},
        ReturnValues="UPDATED_NEW"
    )
   # Format dynamodb response into variable
    responseBody =  hitCountNumber

    # Create api response object that Javascript can read
    apiResponse = {
        "isBase64Encoded": False,
        "statusCode": 200,
        "headers": {
            #'Content-Type': 'text/plain',
            'Access-Control-Allow-Origin': '*'
        },
        "body": responseBody
    }

    # Return api response object
    return apiResponse

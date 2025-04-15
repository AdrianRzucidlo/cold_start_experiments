def lambda_handler(event, context):
    for record in event['Records']:
        sns_message = record['Sns']
        message = sns_message['Message']
        print(f"Received: {message}")
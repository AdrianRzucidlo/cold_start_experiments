from google.cloud import storage

def lambda_handler(event, context):
    for record in event['Records']:
        sns_message = record['Sns']
        message = sns_message['Message']

        try:
            client = storage.Client(project="FAKE")
            buckets = list(client.list_buckets())
        except Exception as e:
            print(f"Received: {message}")
        print(f"Received: {message}")
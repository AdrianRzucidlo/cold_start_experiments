from google.cloud import storage

def main(request):
    try:
        client = storage.Client(project="FAKE")
        buckets = list(client.list_buckets())
    except Exception as e:
        return "OK", 200
    return "OK", 200
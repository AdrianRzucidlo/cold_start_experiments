require "google/cloud/storage"

def lambda_handler(event:, context:)
  project_id = "fake"

  begin
    storage = Google::Cloud::Storage.new(project_id: project_id)
    buckets = storage.buckets

    nil
  rescue StandardError => e
    nil
  end
end
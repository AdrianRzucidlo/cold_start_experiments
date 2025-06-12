# main.rb
require "functions_framework"
require "google/cloud/storage"

FunctionsFramework.http "TestingFunctionRuby" do |request|
  begin
    project_id =  "fake"
    storage = Google::Cloud::Storage.new(project_id: project_id)
    buckets = storage.buckets
    "Done"
  rescue => e
    "Done"
  end
end
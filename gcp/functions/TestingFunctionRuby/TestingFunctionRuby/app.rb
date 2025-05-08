# main.rb
require "functions_framework"

FunctionsFramework.http "TestingFunctionRuby" do |request|
  "Done"
end
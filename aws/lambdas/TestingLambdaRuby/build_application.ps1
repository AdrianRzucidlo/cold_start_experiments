#fsutil file createnew TestingLambdaRuby/fake.bin 209715200

Push-Location ./TestingLambdaRuby

bundle install --path vendor/bundle

Pop-Location

Compress-Archive -Path "./TestingLambdaRuby/*" -DestinationPath TestingLambdaRuby.zip
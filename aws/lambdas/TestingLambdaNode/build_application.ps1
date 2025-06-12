#fsutil file createnew TestingLambdaNode/fake.bin 209715200

Push-Location ./TestingLambdaNode

npm install

Pop-Location

Compress-Archive -Path "./TestingLambdaNode/*" -DestinationPath TestingLambdaNode.zip
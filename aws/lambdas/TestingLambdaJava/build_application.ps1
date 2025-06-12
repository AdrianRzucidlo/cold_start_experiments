cd .\TestingLambdaJava\

mvn clean compile package shade:shade

$UnpackDir = "1"
Remove-Item $UnpackDir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $UnpackDir | Out-Null

Push-Location $UnpackDir

jar xf "..\target\TestingLambdaJava-1.0-SNAPSHOT-shaded.jar"

Pop-Location

#fsutil file createnew $UnpackDir/fake.bin 209715200

Compress-Archive -Path "$UnpackDir\*" -DestinationPath "../TestingLambdaJava.zip" -Force

cd..

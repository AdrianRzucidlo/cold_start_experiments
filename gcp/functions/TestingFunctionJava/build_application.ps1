Set-Location .\TestingFunctionJava\

mvn clean compile package shade:shade

$JarPath = "target\TestingFunctionJava-1.0.0-SNAPSHOT-shaded.jar"
$ZipPath = "..\TestingFunctionJava.zip"

Compress-Archive -Path $JarPath -DestinationPath $ZipPath -Force

Set-Location ..

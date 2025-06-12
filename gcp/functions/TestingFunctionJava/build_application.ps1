Set-Location .\TestingFunctionJava\

# Budujemy zwykły JAR, bez shade
mvn clean package

# Ścieżka do zwykłego JAR-a, bez "-shaded"
$JarPath = "target\TestingFunctionJava-1.0.0-SNAPSHOT.jar"
$ZipPath = "..\TestingFunctionJava.zip"

$TempDir = "tmp-zip-content"
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

# Kopiujemy JAR do tymczasowego folderu jako function.jar (wymagane przez Google Functions)
Copy-Item $JarPath -Destination "$TempDir\function.jar"

# Pakujemy cały folder tymczasowy do ZIP-a
Compress-Archive -Path "$TempDir\*" -DestinationPath $ZipPath -Force

# Usuwamy tymczasowy folder
Remove-Item -Recurse -Force $TempDir

# Wracamy do folderu wyżej
Set-Location ..

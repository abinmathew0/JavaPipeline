@echo off
setlocal
cd /d "%~dp0"

echo 🚧 Starting build and run process... > build-log.txt
echo Directory: %CD% >> build-log.txt

:: Step 1: Check Maven
echo 🔍 Checking Maven... >> build-log.txt
mvn -v >> build-log.txt 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Maven is not installed or not in PATH. >> build-log.txt
    echo Make sure Maven is installed and added to PATH.
    start build-log.txt
    pause
    exit /b
)

:: Step 2: Clean and Build Project
echo 🔨 Running: mvn clean install... >> build-log.txt
mvn clean install >> build-log.txt 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Build failed. Check build-log.txt for details.
    start build-log.txt
    pause
    exit /b
)

:: Step 3: Check if jar file exists
set "JAR=target\enterprise-java-cicd-0.0.1-SNAPSHOT.jar"
if not exist "%JAR%" (
    echo ❌ JAR file not found: %JAR% >> build-log.txt
    start build-log.txt
    pause
    exit /b
)

:: Step 4: Launch browser
echo 🌐 Opening browser to http://localhost:8080/hello
start "" http://localhost:8080/hello

:: Step 5: Run the app
echo 🚀 Running app... >> build-log.txt
java -jar "%JAR%" >> build-log.txt 2>&1

pause

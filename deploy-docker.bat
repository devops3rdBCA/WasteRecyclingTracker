@echo off
REM Waste Recycling Tracker - Docker Deployment Script (Windows)
REM Usage: deploy-docker.bat [dev|prod]

setlocal enabledelayedexpansion

set ENVIRONMENT=%1
if "%ENVIRONMENT%"=="" set ENVIRONMENT=prod

echo ================================================
echo Deploying Waste Recycling Tracker - %ENVIRONMENT%
echo ================================================
echo.

REM Check if Docker is installed
where docker >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ^X^! Docker is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

REM Check if Docker Compose is installed
where docker-compose >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ^X^! Docker Compose is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

REM Load environment variables
if exist ".env.%ENVIRONMENT%" (
    echo Loading environment variables from .env.%ENVIRONMENT%
    for /f "delims== tokens=1,2" %%G in (.env.%ENVIRONMENT%) do (
        set "%%G=%%H"
    )
) else (
    echo Warning: .env.%ENVIRONMENT% not found, using defaults
)

REM Build images
echo.
echo 🔨 Building Docker images...
call docker-compose build --no-cache

REM Stop and remove old containers
echo.
echo ⏹️  Stopping existing containers...
call docker-compose down 2>nul || echo No containers to stop

REM Start services
echo.
echo 🚀 Starting services...
if "%ENVIRONMENT%"=="dev" (
    call docker-compose --profile dev up -d
) else (
    call docker-compose up -d
)

REM Wait for services
echo.
echo ⏳ Waiting for services to be healthy...
timeout /t 10 /nobreak

REM Check health
echo.
echo 🏥 Checking service health...

docker ps | find "waste_recycling_api" >nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ Backend API is running
) else (
    echo ^X^! Backend API failed to start
    call docker-compose logs backend
    pause
    exit /b 1
)

docker ps | find "waste_recycling_ui" >nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ Frontend UI is running
) else (
    echo ^X^! Frontend UI failed to start
    call docker-compose logs frontend
    pause
    exit /b 1
)

docker ps | find "waste_recycling_db" >nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ Database is running
) else (
    echo ^X^! Database failed to start
    call docker-compose logs postgres
    pause
    exit /b 1
)

echo.
echo ================================================
echo ✅ Deployment Successful!
echo ================================================
echo.
echo 📍 Service Endpoints:
echo    Frontend:    http://localhost:3000
echo    Backend API: http://localhost:8081
echo    Database:    postgres://localhost:5432
if "%ENVIRONMENT%"=="dev" (
    echo    PgAdmin:     http://localhost:5050
)
echo.
echo 📊 View logs with: docker-compose logs -f
echo 🛑 Stop services with: docker-compose down
echo.
pause

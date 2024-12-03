# Usage: ./kickstarter.ps1 <project_name>

# Check if docker is up and running
# $dockerIsRunning = (docker ps 2>&1 | Out-String) -match "^(?!error)"
if((docker ps 2>&1) -match '^(?!error)'){
    Write-Host "✅ Docker is running"
 }else{
    Write-Host "🛑 Docker is not running"
    exit 1
 }

# Check if the user has provided an argument
if (!$args){
    Write-Host "🛑 No argument supplied. Please provide the name of the app"
    exit 1
}

# Copy the docker-compose.local.yml.example to docker-compose.local.yml
Copy-Item docker-compose.local.yml.example docker-compose.local.yml

# Replace the {appname} placeholder with the name from cli argument
(Get-Content docker-compose.local.yml.example) -replace "{appname}", "$args" | Out-File -encoding ASCII docker-compose.local.yml

# Create files to connect each server
New-Item -ItemType "directory" -Path "./docker/bash"
New-Item -Path ./docker/bash -Name "connect-webserver.ps1" -ItemType "file" -Value "docker exec -ti $($args)_webserver /bin/bash"
New-Item -Path ./docker/bash -Name "connect-task.ps1" -ItemType "file" -Value "docker exec -ti $($args)_task /bin/bash"
New-Item -Path ./docker/bash -Name "connect-queue.ps1" -ItemType "file" -Value "docker exec -ti $($args)_queue /bin/bash"
New-Item -Path ./docker/bash -Name "connect-redis.ps1" -ItemType "file" -Value "docker exec -ti $($args)_redis /bin/bash"
New-Item -Path ./docker/bash -Name "connect-db.ps1" -ItemType "file" -Value "docker exec -ti $($args)_db /bin/bash"
New-Item -Path ./docker/bash -Name "docker-compose-build.ps1" -ItemType "file" -Value "docker-compose up -d --build"

# Download Laravel
$path = Get-Location
docker run -it -v $path`:/var/www/html serversideup/php:8.4-cli composer create-project laravel/laravel laravel

# Copy all files and folders (even hidden) from laravel to the root of the project and remove laravel folder
Copy-Item -Path laravel\* -Destination . -Recurse
Remove-Item laravel -Recurse

# Copy the .env.example to .env
Copy-Item .env.example .env

# Now build the project
docker-compose -f docker-compose.local.yml build

# Configure application key by running php artisan key:generate on the {appname}_webserver container
docker run -it -v $path`:/var/www/html serversideup/php:8.4-cli php artisan key:generate

docker compose --file docker-compose.local.yml up --build -d

Write-Host "✅ Project $arg has been kickstarted successfully! Build something awesome! 🚀"
# Laravel 11 Docker Starter - Windows
This is a starter project for Laravel 11 using Docker. It includes a web server (nginx with php-fpm), a database server (mysql), and a redis server.

It uses [serversideup](https://serversideup.net/open-source/docker-php/docs) images for the web server, queue worker, and scheduler.

## Installation
1. Clone the repository: `git clone git@github.com:jrmessias/laravel11-docker-starter-windows.git laravel_project`
2. Add execute permission to the `kickstarter.ps1` file by running `chmod +x kickstarter.ps1`
3. Run `./kickstarter.ps1 <project_name>`, replace `<project_name>` with the name of your project
4. Run `docker-compose -f docker-compose.local.yml up -d`
5. Enjoy! 🎉

## Cleanup (Optional, read carefully)
You can remove example docker file and kickstarter script by running `./kickstarter_cleanup.ps1` script and confirm. It simply removes following files:
- `docker-compose.local.yml.example`
- `kickstarter.ps1`
- `kickstarter_cleanup.ps1`
- `.git`

It is useful if you want to use this project as a base for your own project.

## URLs
Once started, you can access Laravel 11 at:
- [http://localhost:8888](http://localhost:8888)
- [https://localhost:444](https://localhost:444)

-----

Based on original project for Linux
- [Laravel 11 Docker Starter](https://github.com/mattb-it/laravel11-docker-starter)

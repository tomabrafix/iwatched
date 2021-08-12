#!/bin/bash

set -e
set -u


cd "$(dirname "$(realpath "$0")")"


docker-compose up -d
docker-compose run --rm --no-deps iwatched-server composer install
docker-compose run --rm --no-deps iwatched-server php artisan storage:link
docker-compose run --rm --no-deps iwatched-server php artisan migrate -n --force
mkdir -p ./storage/app/imdb
docker-compose run --rm --no-deps iwatched-server php artisan import:titles
docker-compose run --rm --no-deps iwatched-server php artisan import:elastic

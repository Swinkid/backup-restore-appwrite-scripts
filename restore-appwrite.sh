#!/bin/bash
cd ~/appwrite || exit

echo "Restoring Databases..."
docker-compose exec -T mariadb sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < $PWD/backup/dump.sql

echo "Restoring Volumes..."
docker-compose stop
docker run --rm --volumes-from "$(docker-compose ps -q appwrite)" -v $PWD/backup:/restore ubuntu bash -c "cd /storage/functions && tar xvf /restore/functions.tar --strip 1"
docker run --rm --volumes-from "$(docker-compose ps -q appwrite)" -v $PWD/backup:/restore ubuntu bash -c "cd /storage/uploads && tar xvf /restore/uploads.tar --strip 1"
docker-compose up -d

echo "Restore complete"

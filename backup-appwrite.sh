#!/bin/bash
cd ~/appwrite || exit
rm -rf backup
mkdir backup

echo "Backing up databases to ${PWD}/backup/dump.sql..."
docker-compose exec -T mariadb sh -c 'exec mysqldump --all-databases --add-drop-database -u"$MYSQL_USER" -p"$MYSQL_ROOT_PASSWORD"' > $PWD/backup/dump.sql

echo "Backing up functions and uploads..."
echo "Stopping all containers for safe volume backup..."
docker-compose stop
docker run --rm --volumes-from "$(docker-compose ps -q appwrite)" -v $PWD/backup:/backup ubuntu bash -c "cd /storage/functions && tar cvf /backup/functions.tar ."
docker run --rm --volumes-from "$(docker-compose ps -q appwrite)" -v $PWD/backup:/backup ubuntu bash -c "cd /storage/uploads && tar cvf /backup/uploads.tar ."
echo "Restarting all containers..."
docker-compose up -d

echo "Backup complete"

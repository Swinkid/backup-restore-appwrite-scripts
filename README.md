# Backup / Restore Appwrite
This repository contains shell scripts to backup the following items in Appwrite:
- Functions
- Storage (Uploads)
- MariaDB SQL Dump

Appwrite should  be able to figure itself out once you've restored from your backup. Backups are stored in ~/appwrite/backup.

This script will automatically bring down and bring up your appwrite docker containers to ensure volumes are backed up in a safe way and not produce any corruption - I may update this in the future to include flags NOT to bring it down (For example in production).


## Usage
These scripts assume that your appwrite directory (that contains docker-compose.yml) is in ~/appwrite. Possible future updates to provide this via a environment variable or argument (Pull Requests welcome).

### Environment Variables
Ensure the below variables are set before running scripts, or pass them while executing below scripts.

- MYSQL_USER=user
- MYSQL_ROOT_PASSWORD=your-root-password

### Ensure scripts are  executable
```
chmod +x ./backup-appwrite.sh
chmod +x ./restore-appwrite.sh
```

### Backup
```
./backup-appwrite.sh
```

### Restore
```
./restore-appwrite.sh
```

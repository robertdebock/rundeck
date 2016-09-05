#!/bin/bash

backupdatabase() {
  docker exec mysql sh -c 'exec mysqldump --all-databases -uroot -p"rundeck"' > data/database.mysql
}

backupfiles() {
 for directory in /var/rundeck /var/lib/rundeck/var/storage /var/lib/rundeck/logs ; do 
   filename=$(echo ${directory} | sed 's%/%%g').tar.gz
   echo "Backing up ${directory}..."
   docker exec rundeck /bin/bash -c "cd ${directory} ; tar -czf - *" > data/${filename}
 done
}

backupdatabase
backupfiles

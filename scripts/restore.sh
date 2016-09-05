#!/bin/bash

restoredatabase() {
  docker exec -i mysql mysql -uroot -p"rundeck" < data/database.mysql
}

restorefiles() {
  for directory in /var/rundeck /var/lib/rundeck/var/storage /var/lib/rundeck/logs ; do
    filename=$(echo ${directory} | sed 's%/%%g').tar.gz
    cat data/${filename} | docker exec -i rundeck /bin/bash -c "cat > ${dirname}/${filename}"
    docker exec rundeck tar -xvzf ${dirname}/${filename} -C ${directory}
  done
}

restoredatabase
restorefiles

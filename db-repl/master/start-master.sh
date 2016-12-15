#!/bin/bash

docker run --name mysql-master -e MYSQL_ALLOW_EMPTY_PASSWORD=true -p 13306:3306 -d mysql-master:0.1
sleep 10

# master setup
mysql -u root -h "$(docker-machine ip default)" -P 13306 -e "GRANT REPLICATION SLAVE ON *.* TO 'repli'@'172.17.0.%' IDENTIFIED BY 'repli';"
mysql -u root -h "$(docker-machine ip default)" -P 13306 -e "flush privileges;"

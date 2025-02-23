#!/bin/bash

###
# Проверяем число документов в коллекции
###

printf "Проверяем число документов в shard1"
printf "\n"

docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
exit();
EOF

printf "\n"
printf "Проверяем число документов в shard1_replica1"
printf "\n"
docker compose exec -T shard1_replica1 mongosh --port 27021 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
exit();
EOF

printf "\n"
printf "Проверяем число документов в shard1_replica2"
printf "\n"
docker compose exec -T shard1_replica2 mongosh --port 27022 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
exit();
EOF

printf "\n"
printf "Проверяем число документов в shard2"
printf "\n"
docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

printf "\n"
printf "Проверяем число документов в shard2_replica1"
printf "\n"
docker compose exec -T shard2_replica1 mongosh --port 27023 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

printf "\n"
printf "Проверяем число документов в shard2_replica2"
printf "\n"
docker compose exec -T shard2_replica2 mongosh --port 27024 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF
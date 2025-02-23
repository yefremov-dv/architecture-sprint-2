#!/bin/bash

###
# Инициализируем шарды
# Соединяем в набор shard1 реплики shard1, shard1_replica1, shard1_replica2
# Соединяем в набор shard2 реплики shard2, shard2_replica1, shard2_replica2
###

docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
rs.initiate({_id: "shard1", members: [{_id: 0, host: "shard1:27018"},{_id: 1, host: "shard1_replica1:27021"},{_id: 2, host: "shard1_replica2:27022"}]})
EOF

printf "\n"

docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
rs.initiate({_id: "shard2", members: [{_id: 0, host: "shard2:27019"},{_id: 1, host: "shard2_replica1:27023"},{_id: 2, host: "shard2_replica2:27024"}]})
EOF
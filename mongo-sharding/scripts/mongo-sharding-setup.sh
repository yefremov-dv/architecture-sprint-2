#!/bin/bash

###
# Инициализируем сервер конфигурации
# Инициализируем роутер и добавим в него шарды
# Заполняем somedb объектам
###

docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
rs.initiate({_id : "config_server", configsvr: true, members: [{ _id : 0, host : "configSrv:27017" }]});
exit();
EOF

printf "\n"
docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
rs.initiate({_id : "shard1", members:[{ _id : 0, host : "shard1:27018" }]});
EOF

printf "\n"
docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
rs.initiate({_id : "shard2", members:[{ _id : 0, host : "shard2:27019" }]});
EOF


printf "\n"
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.addShard( "shard1/shard1:27018");
sh.addShard( "shard2/shard2:27019");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i})
db.helloDoc.countDocuments() 
exit(); 
EOF


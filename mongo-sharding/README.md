# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Инициализируем по configSrv, шарды и роутер Mongo. Передаем информацию о шардах в роутер. Наполняем шарды документами 

```shell
./scripts/mongo-sharding-setup.sh
```

## Как проверить

Убедимся, что в каждом из двух шардов появились документы (492 для одного шарда и 508 для второго шарда) 

```shell
./scripts/mongo-db-checker.sh
```
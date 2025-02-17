#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Error: pass a relative or absolute path to the cattails root directory"
  exit 1
fi

until [ "$(docker inspect -f {{.State.Health.Status}} mongodb)" = "healthy" ]; do
  sleep 1;
done;

# Connect to the MongoDB container without authentication
docker exec mongodb mongosh --quiet \
  --eval 'use admin' \
  --eval 'db.auth({ user: "root", pwd: "1234" })' \
  --eval 'use avocet' \
  --eval 'db.dropDatabase()' \
  --eval 'db.dropAllUsers()' \
  --eval 'db.createUser({ user: "avocet-admin", pwd: "1234", roles: [{ role: "readWrite", db: "avocet" }] })' \
  --eval 'show users' \

# Run the database initialization scripts from inside the management-api container
docker exec management-api npx tsx /app/mongodb/initialize-mongo-indexes.ts
docker exec management-api npx tsx /app/mongodb/insert-initial-data.ts

# Run the exampleData script from inside the management-api container
docker exec management-api npm run exampleData

echo "Mongo setup complete"
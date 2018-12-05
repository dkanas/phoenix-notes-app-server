#!/bin/sh
set -e

until PGPASSWORD=$POSTGRES_PASSWORD psql -h db -U "postgres" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

mix ecto.create
mix ecto.migrate

mix phx.server

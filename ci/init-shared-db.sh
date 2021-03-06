#!/bin/bash

set -e

export PGPASSWORD="${POSTGRES_PASSWORD}"

host=$(terraform output -state="${STATE_FILE}" -module=rds_shared_postgres rds_host)
extensions=("hstore" "pg_trgm")

for extension in "${extensions[@]}"; do
  psql -h "${host}" -U "${POSTGRES_USERNAME}" -d template1 -c "create extension if not exists ${extension};"
done

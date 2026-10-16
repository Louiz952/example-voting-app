#!/usr/bin/env bash

set -euo pipefail

# Generate an ephemeral database password when one is not already provided.
if [[ -z "${POSTGRES_PASSWORD:-}" ]]; then
  export POSTGRES_PASSWORD
  POSTGRES_PASSWORD="$(python3 -c 'import secrets; print(secrets.token_hex(24))')"
fi

cleanup() {
  echo "Stopping test environment..."
  docker compose down -v --remove-orphans
}

trap cleanup EXIT

echo "Building and starting application..."
docker compose up -d --build

echo "Waiting for services to become ready..."
sleep 15

echo "Checking Compose services..."
docker compose ps

echo "Checking voting application..."
curl --fail --silent --show-error http://localhost:8080 > /dev/null

echo "Checking results application..."
curl --fail --silent --show-error http://localhost:8081 > /dev/null

echo "Smoke test passed."
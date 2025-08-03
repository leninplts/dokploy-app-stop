#!/usr/bin/env sh
set -e

: "${INPUT_API_KEY:?api_key es obligatorio}"
: "${INPUT_APP_ID:?application_id es obligatorio}"
: "${INPUT_URL:?dokploy_url es obligatorio}"

curl -X POST "$INPUT_URL/api/application.stop" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $INPUT_API_KEY" \
  -d "{\"applicationId\":\"$INPUT_APP_ID\"}"
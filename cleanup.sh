#!/bin/bash

DIR="$(dirname "$0")"
source "$DIR/config.sh"

echo "DOMAIN: ${DOMAIN}"

RECORDS=$(curl -s -X GET "https://napi.arvancloud.ir/cdn/4.0/domains/$DOMAIN/dns-records" \
    -H "Authorization: Apikey $API_KEY")

RECORD_ID=$(echo "$RECORDS" | jq -r '.data[] | select(.type == "txt" and .name == "_acme-challenge").id')

echo "Record ID: $RECORD_ID"

curl -X DELETE "https://napi.arvancloud.ir/cdn/4.0/domains/${DOMAIN}/dns-records/${RECORD_ID}" \
    -H "Authorization: Apikey $API_KEY"
    
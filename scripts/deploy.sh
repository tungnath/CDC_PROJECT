#!/bin/bash

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "Error: .env file not found."
  exit 1
fi

# Debug: Print environment variables
echo "DB_HOST: ${DB_HOST}"
echo "DB_PORT: ${DB_PORT}"
echo "DB_USER: ${DB_USER}"
echo "DB_PASSWORD: ${DB_PASSWORD}"
echo "CONNECT_REST_HOST: ${CONNECT_REST_HOST}"
echo "KAFKA_BROKER: ${KAFKA_BROKER}"
echo "ORDER_DB_NAME: ${ORDER_DB_NAME}"
echo "PAYMENT_DB_NAME: ${PAYMENT_DB_NAME}"
echo ""; echo "";

# Substitute environment variables in JSON files
envsubst < connectors/source/order-db-source-connector.json > connectors/source/order-db-source-connector-resolved.json
envsubst < connectors/sink/payment-db-sink-connector.json > connectors/sink/payment-db-sink-connector-resolved.json

deployConnector() {
  local connectorData=$1
  local connectorName=$2

  if [ -z "$connectorData" ] || [ -z "$connectorName" ]; then
    echo "Error: Both connector data file and connector name are required"
    return 1
  fi

  if [ ! -f "$connectorData" ]; then
    echo "Error: Connector data file '$connectorData' not found"
    return 1
  fi

  echo "Deploying connector: $connectorName"
  curl -X PUT -H "Content-Type: application/json" --data @$connectorData ${CONNECT_REST_HOST}/connectors/${connectorName}/config
  echo ""; echo "";
}

# Deploy Kafka Connect connectors
deployConnector 'connectors/source/order-db-source-connector-resolved.json' 'order-db-source-connector'

deployConnector 'connectors/sink/payment-db-sink-connector-resolved.json' 'payment-db-sink-connector'

# Clean up resolved files
rm connectors/source/order-db-source-connector-resolved.json
rm connectors/sink/payment-db-sink-connector-resolved.json

echo "Connectors deployed and resolved files cleaned up!"

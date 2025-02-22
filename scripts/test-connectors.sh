#!/bin/bash

# Load environment variables
source .env

# Test if connectors are running
curl ${CONNECT_REST_HOST}/connectors
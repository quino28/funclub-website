#!/bin/bash

set -eu

RAILS_ROOT=$(cd $(dirname $0)/../ && pwd)
DOCKER_COMPOSE_FILE="${RAILS_ROOT}/docker-compose.yml"

function usage() {
  cat <<EOF
Usage:
  bash $0 [command]
Commands:
  init initialize
EOF
}

function init() {
    docker-compose down --volumes --remove-orphans --rmi all
    docker-compose --env-file .env.local up -d --build
    docker-compose exec rails rails db:schema:load
}

if [ $# -eq 0 ];then
  usage
  exit 1
fi

$1

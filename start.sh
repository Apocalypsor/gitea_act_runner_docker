#!/bin/sh

set -e
runner_conf=$(cat /runner/.runner)

if [ -z "$runner_conf" ]; then
  if [ -z "$RUNNER_NAME" ]; then
    RUNNER_NAME=$(head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)
  fi
  /runner/act_runner register --instance ${GITEA_URL} --token ${TOKEN} --name $RUNNER_NAME --no-interactive
fi

/runner/act_runner daemon

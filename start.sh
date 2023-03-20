#!/bin/bash

set -e
runner_conf=$(cat /runner/.runner)

if [ -z "$runner_conf" ]; then
  /runner/act_runner register --instance ${GITEA_URL} --token ${TOKEN} --no-interactive
fi

/runner/act_runner daemon

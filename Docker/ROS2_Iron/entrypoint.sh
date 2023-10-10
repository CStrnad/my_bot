#!/usr/bin/env bash

set -e

cd src/my_bot/
git pull
source /opt/ros/iron/setup.bash

echo "Provided arguments: $@"

exec $@

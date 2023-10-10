#!/usr/bin/env bash

set -e

cd src/my_bot/
git pull
source /opt/ros/iron/setup.bash
cd ../..
source install/local_setup.bash
colcon build --symlink-install

echo "Provided arguments: $@"

exec $@

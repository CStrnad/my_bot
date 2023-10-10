#!/usr/bin/env bash

set -e

cd src/my_bot/
git pull
source /opt/ros/iron/setup.bash
cd ../..
source install/local_setup.bash



# source /opt/ros/iron/setup.bash
# source install/local_setup.bash
# ros2 launch my_bot launch_sim.launch.py world:=./src/my_bot/worlds/sim.world

echo "Provided arguments: $@"

exec $@

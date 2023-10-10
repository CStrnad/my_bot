#!/usr/bin/env bash

set -e

source /opt/ros/iron/setup.bash
source install/local_setup.bash
ros2 launch my_bot launch_sim.launch.py #world:=./src/my_bot/worlds/sim.world

echo "Provided arguments: $@"

exec $@

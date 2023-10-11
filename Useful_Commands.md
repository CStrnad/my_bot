# Useful ROS2 Commands

## Basic Commands (Somewhat generalized)

To initialize keyboard control:

ros2 run teleop_twist_keyboard teleop_twist_keyboard

To initialize Gazebo Simulation via launch file:

ros2 launch my_bot launch_sim.launch.py

ros2 launch my_bot launch_sim.launch.py world:=./src/my_bot/worlds/sim.world

## Foxglove Studio

To enable the rosbridge service, on the VM run:

ros2 launch rosbridge_server rosbridge_websocket_launch.xml

Then go to the Foxglove program and connect using the rosbridge default conneciton settings.

SLAM Toolbox

Online Asynchronous...
ros2 launch slam_toolbox online_async_launch.py params_file:=./src/my_bot/config/mapper_params_online_async.yaml use_time_time:=true

# Generate map and save it! Then change the config above to use mapping and reference the map file.

Launch Nav2 bringup for control...
ros2 launch nav2_bringup navigation_launch.py use_sim_time:=true

Enable Map Server
ros2 run nav2_map_server map_server --ros-args -p yaml_filename:=my_map_save.yaml -p use_sim_time:=true
ros2 run nav2_util lifecycle_bringup map_server

Launch AMCL
ros2 run nav2_amcl amcl --ros-args -p use_sim_time:=true
ros2 run nav2_util lifecycle_bringup amcl




AMCL Way Actually!!!
Launch Gazebo sim, and rviz as per usual.

Launch  nav2 localization...
ros2 launch nav2_bringup localization_launch.py map:=./src/my_bot/maps/my_map.yaml

Launch nav2 navigation...


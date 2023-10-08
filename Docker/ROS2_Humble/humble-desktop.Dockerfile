ARG ROS_DISTRO=humble

FROM osrf/ros:humble-desktop-full
SHELL ["/bin/bash", "-c"]

# Basic updates
RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip

# Create working directory for ROS project and clone-in the git repo
RUN mkdir -p ~/dev_ws/src
WORKDIR /dev_ws/src
RUN git clone https://github.com/CStrnad/my_bot

## Source ROS 
RUN source /opt/ros/${ROS_DISTRO}/setup.bash

# Source the project, get any missing dependancies, build.
WORKDIR /dev_ws
RUN echo "$PWD"
WORKDIR /dev_ws
RUN source install/setup.bash \
    && rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y \
    && colcon build --symlink-install

RUN echo "Setup Complete."
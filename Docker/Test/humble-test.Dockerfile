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
# RUN source /opt/ros/${ROS_DISTRO}/setup.bash
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN source ~/.bashrc

# Source the project, get any missing dependancies, build.
# WORKDIR /dev_ws
# RUN echo "$PWD"
WORKDIR /dev_ws
# RUN colcon build --symlink-install \
#     && source install/setup.bash \
#     && rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y

RUN /bin/bash -c "source /opt/ros/humble/setup.bash; colcon build --symlink-install"
# RUN colcon build --symlink-install
RUN source install/setup.bash
RUN rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y

RUN echo "Setup Complete."
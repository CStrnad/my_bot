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
WORKDIR /dev_ws
RUN /bin/bash -c "source /opt/ros/humble/setup.bash; colcon build --symlink-install"
RUN source install/setup.bash
RUN rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
RUN sudo apt install ros-humble-gazebo-ros-pkgs -y
RUN sudo apt-get install ros-humble-rosbridge-server -y
RUN sudo apt-get install ros-humble-slam-toolbox -y
RUN sudo apt-get install ros-humble-navigation2 -y
RUN sudo apt-get install ros-humble-nav2-bringup -y
RUN sudo apt-get install ros-humble-twist-mux -y
# RUN sudo apt-get install ros-humble-


ENV DISPLAY=host.docker.internal:0.0

RUN echo "Setup Complete."

COPY humble-entrypoint.sh /humble-entrypoint.sh
# COPY gazebo_entrypoint.sh /gazebo_entrypoint.sh
# COPY rsp_entrypoint.sh /rsp_entrypoint.sh
ENTRYPOINT ["bash", "/humble-entrypoint.sh"]


# CMD ["bash"]

# sudo apt install ros-humble-gazebo-ros-pkgs -y
# sudo apt-get install ros-humble-rosbridge-server -y
# sudo apt-get install ros-humble-slam-toolbox -y
# sudo apt-get install ros-humble-navigation2 -y
# sudo apt-get install ros-humble-nav2-bringup -y
# sudo apt-get install ros-humble-twist-mux -y
# sudo apt-get install ros-humble-xacro -y
# sudo apt-get install ros-humble-ros2-control ros-humble-ros2-controllers ros-humble-gazebo-ros2-control -y
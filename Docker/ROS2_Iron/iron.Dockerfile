ARG ROS_DISTRO=iron

FROM osrf/ros:iron-desktop-full
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
RUN echo "source /opt/ros/iron/setup.bash" >> ~/.bashrc
RUN source ~/.bashrc

# Source the project, get any missing dependancies, build.
WORKDIR /dev_ws
RUN /bin/bash -c "source /opt/ros/iron/setup.bash; colcon build --symlink-install"
RUN source install/setup.bash
RUN rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
RUN sudo apt install ros-iron-gazebo-ros-pkgs -y

ENV DISPLAY=host.docker.internal:0.0

RUN echo "Setup Complete."

COPY entrypoint.sh /entrypoint.sh
# COPY gazebo_entrypoint.sh /gazebo_entrypoint.sh
# COPY rsp_entrypoint.sh /rsp_entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]


# CMD ["bash"]
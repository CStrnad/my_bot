# Notes regarding the structure and use of Docker

When launching a docker container, for Windows, include:
-e DISPLAY=host.docker.internal:0

## Dockerfile vs docker-compose

Dockerfile: A text doc with a series of commands used to build a docker image.

Docker-compose: Tool for defining and running multi-container applications.

## Process of setting up a stack

1. Create a Dockerfile and populate.
2. Create a docker-compose.yaml file to describe the instances needed.
3. Call `docker-compose build` to build the stack.
4. Call `docker-compose up` to start the stack.

**Or just use `docker build -t <name_of_image>` and then run the container with `docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix <name_of_image>`**

!YOU NEED TO LAUNCH XLAUNCH WITH THE ADDITIONAL PARAMETER OF `-ac`!

docker run -it --name ros-iron-test -e DISPLAY=host.docker.internal:0.0 -e LIBGL_ALWAYS_INDIRECT=0 osrf/ros:iron-desktop-full bash

echo "source /opt/ros/iron/setup.bash" >> ~/.bashrc
source ~/.bashrc

In another terminal:
docker exec -it ros-test bash




docker run -it test-ros2-humble-desktop-gui bash

docker run -it --name ros-humble-test -e DISPLAY=host.docker.internal:0.0 -e LIBGL_ALWAYS_INDIRECT=0 test-ros2-humble-desktop-gui bash


Look at this later:
https://www.youtube.com/watch?v=RbP5cARP-SM


For Iron:

To build the docker file:
docker build -f .\iron.Dockerfile -t my_image .

MANUAL WAY:
Correct command, but make sure Moba is up and running or no GUI.
docker run -it --net=host -e DISPLAY=host.docker.internal:0 -e LIBGL_ALWAYS_INDIRECT=0 -v /tmp/.X11-unix:/tmp/.X11-unix my_image rviz2

Compose file way:

docker-compose up

docker-compose down -rmi all

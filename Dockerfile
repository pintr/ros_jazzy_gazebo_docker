FROM osrf/ros:jazzy-desktop

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Use the argument to install the correct packages
RUN apt-get update && apt-get install -y \
    terminator \
    ros-jazzy-ros-gz \
    && rm -rf /var/lib/apt/lists/*

# Create a ROS 2 workspace
WORKDIR /root/ros2_ws

# Use the argument to source the correct setup file
RUN echo "source /opt/ros/jazzy/setup.bash" >> /root/.bashrc

# ROS Gazebo Docker Environment

A Docker-based development environment for ROS 2 Jazzy with Gazebo simulation support.

## Overview

This project provides a containerized ROS 2 development environment that includes:
- ROS 2 Jazzy Desktop
- Gazebo simulation support via ros-gz
- X11 forwarding for GUI applications
- GPU acceleration support (optional)

## Prerequisites

- Docker and Docker Compose installed
- X11 server running (for GUI applications)
- Optional: NVIDIA GPU with Docker GPU support for hardware acceleration

## Quick Start

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd ros_gazebo_docker
   ```

2. Make the run script executable:
   ```bash
   chmod +x run.sh
   ```

3. Start the environment:
   ```bash
   ./run.sh
   ```

The script will:
- Build the Docker image
- Start the container with proper X11 forwarding
- Drop you into a bash shell inside the container

## Project Structure

```
ros_gazebo_docker/
├── docker-compose.yml    # Docker Compose configuration
├── Dockerfile           # Container build instructions
├── run.sh              # Convenience script to start the environment
├── src/                # Your ROS 2 packages go here
└── README.md           # This file
```

## Usage

### Running Gazebo

To start Gazebo simulation:

```bash
gz sim
```

### Adding Your ROS 2 Packages

Place your ROS 2 packages in the `src/` directory. They will be automatically mounted into the container at `/root/ros2_ws/src/`.

## GPU Acceleration (Optional)

For NVIDIA GPU acceleration, uncomment the deployment section in `docker-compose.yml`:

```yaml
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: all
          capabilities: [gpu, utility, graphics, display]
```

## Troubleshooting

### X11 Permission Issues

If you encounter X11 permission errors:

```bash
xhost +local:docker
```

### Container Won't Start

Check the logs:

```bash
docker compose logs ros_jazzy_env
```

### GUI Applications Not Displaying

Ensure X11 forwarding is working:

```bash
echo $DISPLAY
xhost +local:docker
```

## Development Workflow

1. Place your ROS 2 packages in the `src/` directory
2. Start the container with `./run.sh`
3. Build your workspace: `colcon build`
4. Source the workspace: `source install/setup.bash`
5. Run your nodes/launch files

## Stopping the Environment

To stop the container:

```bash
# From outside the container
docker compose down

# Or press Ctrl+D inside the container to exit
```
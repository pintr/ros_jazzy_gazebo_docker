#!/bin/bash

# Disable BuildKit to avoid connection issues
export DOCKER_BUILDKIT=0

# Allow X11 forwarding
xhost +local:docker

# Clean up any existing containers
docker compose down --remove-orphans

# Build and start the container with legacy build system
docker compose up --build -d --wait

# Check if the container is running
if docker compose ps | grep -q "Up"; then
    echo "Container is running successfully!"
    docker compose exec ros_jazzy_env bash
else
    echo "Container failed to start. Checking logs..."
    docker compose logs ros_jazzy_env
fi

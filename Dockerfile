# File: cpp_runner/Dockerfile

# Use an official Ubuntu image. It's multi-arch and will work on your Orange Pi (ARM64).
FROM ubuntu:22.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install C++ compiler, make, and other build tools
RUN apt-get update && \
    apt-get install -y build-essential cmake && \
    rm -rf /var/lib/apt/lists/*

# Create a working directory inside the container for the student's code
WORKDIR /app

# Copy the entrypoint script into the container and make it executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint script as the command to run when the container starts
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
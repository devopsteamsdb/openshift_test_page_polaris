# Use the official PowerShell image as the base image
FROM mcr.microsoft.com/powershell:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq fio && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Install Polaris module
RUN pwsh -Command "Install-Module -Name Polaris -Force -Scope AllUsers"

# Expose the port that Polaris will listen on
EXPOSE 8080

# Set the entrypoint to run the Polaris server script
ENTRYPOINT ["pwsh", "-File", "/home/myuser/start-polaris.ps1"]

# Create a non-root user
RUN useradd -m myuser

# Copy the server script into the container
COPY * /home/myuser/

RUN chown -R myuser:myuser /home/myuser

# Set the working directory
WORKDIR /home/myuser

# Set the user as the default
USER myuser
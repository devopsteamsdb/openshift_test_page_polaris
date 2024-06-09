# Use the official PowerShell image as the base image
FROM mcr.microsoft.com/powershell:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq fio && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Install Polaris module
RUN pwsh -Command "Install-Module -Name Polaris -Force -Scope AllUsers"

# Copy the server script into the container
COPY * /

# Expose the port that Polaris will listen on
EXPOSE 8080

# Set the entrypoint to run the Polaris server script
ENTRYPOINT ["pwsh", "-File", "/start-polaris.ps1"]

# Avocet Docker Compose Stack Setup Guide

This guide will walk you through the process of setting up and running the application using Docker containers.

## Prerequisites

- Docker and Docker Compose installed on your system
- Git (for cloning the repository)

## Setup Instructions

### 1. Environment Configuration

After cloning the repository and navigating to the project's root directory, locate and configure the environment files:

- Find all `.env` files in the project
- Replace the marked environment variables with your specific values
- Note: Some default values can be kept as is

### 2. Build and Run Containers

Launch the Docker container stack using Docker Compose:

```bash
docker compose up
```

This command will build and start all required containers.

### 3. Initialize Database

For first-time setup only, run the database initialization script:

```bash
./init-db.sh .
```

**Important**: This step should only be performed once, during the initial setup.

### 4. Access the Application

Once all containers are running, you can access the application dashboard at:

http://localhost:4173

## Troubleshooting

If you encounter any issues:
- Ensure all environment variables are properly configured
- Verify that all required ports are available on your system

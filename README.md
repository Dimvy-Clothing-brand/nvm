# Node Version Manager (NVM)

Node Version Manager (NVM) is a POSIX-compliant bash script to manage multiple active node.js versions.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)

## Introduction

NVM allows you to install and switch between multiple versions of Node.js. This is particularly useful for testing and developing applications that rely on different Node.js versions.

## Features

- Install and manage multiple Node.js versions.
- Switch between different Node.js versions seamlessly.
- List installed Node.js versions.
- Remove Node.js versions that are no longer needed.

## Installation

To install NVM, follow these steps:

1. Clone the repository:

   ```sh
   git clone https://github.com/nodoubtz/nvm.git
   ```

2. Navigate to the project directory:

   ```sh
   cd nvm
   ```

3. Run the installation script:

   ```sh
   ./install.sh
   ```

## Usage

To use NVM, follow these commands:

- **Install a specific Node.js version:**

  ```sh
  nvm install <version>
  ```

- **Switch to a specific Node.js version:**

  ```sh
  nvm use <version>
  ```

- **List installed Node.js versions:**

  ```sh
  nvm list
  ```

- **Remove a specific Node.js version:**

  ```sh
  nvm uninstall <version>
  ```

For more detailed usage instructions, refer to the [official documentation](https://github.com/nodoubtz/nvm#usage).

## Docker: Building and Running the Container

This project provides a Dockerfile for a development environment based on Ubuntu and Node.js (via nvm).

### Build the Docker Image

```sh
# From the project root directory:
docker build -t nvm-dev .
```

### Run the Container Interactively

```sh
docker run --rm -it nvm-dev
```

This will drop you into a bash shell as the `nvm` user, with nvm and Node.js available.

### Run a Node.js Command in the Container

```sh
docker run --rm -it nvm-dev node --version
```

You can also mount your local project directory for development:

```sh
docker run --rm -it -v "$PWD":/workspace -w /workspace nvm-dev
```

The Dockerfile is based on `ubuntu:22.04` and installs Node.js using nvm for maximum compatibility.

## GitHub Actions and Events

You can automate building, testing, and other workflows for this project using GitHub Actions. Below is an example workflow configuration and a list of common events that can trigger these actions.

### Example Workflow: Build and Test

Create a file at `.github/workflows/ci.yml` with the following content:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build Docker image
        run: docker build -t nvm-dev .
      - name: Run tests in container
        run: docker run --rm nvm-dev bash -c "npm test || true"
```

### Common Events

- `push`: Triggered when you push commits to a branch.
- `pull_request`: Triggered when a pull request is opened or updated.
- `workflow_dispatch`: Allows you to manually trigger the workflow from the GitHub UI.

You can customize these workflows and events to fit your development process.

## Requirements

- Docker (for containerized development)
- GNU Make (for Makefile tools)
- Node.js and npm (if running locally, managed via nvm)
- Bash, Zsh, Dash, or Sh (for shell compatibility)
- Git (for version control)

## Security

If you discover a security vulnerability, please report it by opening an issue or contacting the maintainers directly. We encourage responsible disclosure and will address issues promptly.

- Do not share sensitive information in public issues.
- Keep dependencies up to date.
- Review and follow best practices for shell scripting and Node.js security.

## Billing / Billable Work

This project includes billable work. Please ensure all time and contributions are tracked appropriately. If you are working on this project as a paid contributor, submit your hours and deliverables according to the agreed process to ensure timely payment.

For questions about billing or compensation, contact the project owner or your manager.

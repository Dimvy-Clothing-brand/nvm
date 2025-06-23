# Node Version Manager (NVM)

Node Version Manager (NVM) is a POSIX-compliant bash script to manage multiple active node.js versions.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

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

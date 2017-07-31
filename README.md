# docker-compose for Symfony env

Out of the box symfony environment using docker-compose. It contains:
- PHP-FPM optimized
- nginx as web server
- MariaDB as mysql-like server
- XDebug (optional)
- GD libraries (optional)

## Installation
### New project
1. `curl -L https://goo.gl/b5vtmq | bash -s TARGET_DIR`
    
    where `TARGET_DIR` is your new project directory.
1. [setup](#setup) your env
1. `docker-compose up`
1. Open [localhost:8080](http://localhost:8080)

A new symfony app will be installed in `app` directory.

### Existing Project
1. Clone this repo
1. Put your symfony app contents in `app` directory
1. [setup](#setup) your env
1. `docker-compose up`
1. Open [localhost:8080](http://localhost:8080)

## Setup
Before build this image, copy `.env.dist` in `.env` and check configuration you want.

### .env parameters
- `DCSF_MYSQL=1` installs `pdo pdo_mysql` extensions
- `DCSF_XDEBUG=1` installs `xdebug` with `default_enable=1`
- `DCSF_XDEBUG_HOST` [see XDebug on Mac](#xdebug-on-mac)
- `DCSF_GD=1` installs `gd` extensions (for image manipulation)

These variables are used building time. If you want to enable/disable after first run, you have to rebuild it: `docker-compose build php`.

### XDebug on Mac
Inside docker container, the only way to communicate with xdebug is with static ip (ref. [xdebug/remote#communication](https://xdebug.org/docs/remote#communication)).

Docker for Mac uses a VM as host for docker containers. To be reached, you xdebug server must be visible from php container.
In Docker for Mac 17.06+, it works using `docker.for.mac.localhost` hostname.

If you're using Docker for Mac 17.05 or below, you have to create an alias to your local IP: `sudo ifconfig lo0 alias 10.254.254.254`. Then put aliased IP to `.env` file:
```
DCSF_XDEBUG_HOST=10.254.254.254
```

Credits: [https://gist.github.com/chadrien/c90927ec2d160ffea9c4](https://gist.github.com/chadrien/c90927ec2d160ffea9c4)
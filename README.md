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
- `DCSF_TIMEZONE=Europe/Rome` set server timezone
- `DCSF_PHP_DISPLAY_ERROR=On` enable/disable errors
- `DCSF_MYSQL=1` installs `pdo pdo_mysql` extensions
- `DCSF_XDEBUG=1` installs `xdebug` with `default_enable=1`
- `DCSF_XDEBUG_HOST` [see XDebug on Mac](#xdebug-on-mac)
- `DCSF_GD=1` installs `gd` extensions (for image manipulation)

These variables are used building time. If you want to enable/disable after first run, you have to rebuild it: `docker-compose build php`.

## Docker for Mac

Docker for Mac has still big problems of slowness with shared volumes (Ref. [docker/for-mac#77](https://github.com/docker/for-mac/issues/77)). To fast up your symfony, remove comments in `docker-compose.yml` and use `cached` volumes (Ref: [docker.com/osxfs-caching/](https://docs.docker.com/docker-for-mac/osxfs-caching/))

```
- ./app/vendor:/var/www/app/vendor:cached
- ./app/var/cache:/var/www/app/var/cache:cached
- ./app/var/logs:/var/www/app/var/logs:cached
```

### XDebug on Mac
Inside docker container, the only way to communicate with xdebug is with static ip (ref. [xdebug/remote#communication](https://xdebug.org/docs/remote#communication)).

Docker for Mac uses a VM as host for docker containers. To be reached, you xdebug server must be visible from php container.
In Docker for Mac 17.06+, it works using `docker.for.mac.localhost` hostname.

If you're using Docker for Mac 17.05 or below, please [update](https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac). If you can't, you have to create an alias to your local IP: `sudo ifconfig lo0 alias 10.254.254.254`. Then put aliased IP to `.env` file:
```
DCSF_XDEBUG_HOST=10.254.254.254
```

Credits: [https://gist.github.com/chadrien/c90927ec2d160ffea9c4](https://gist.github.com/chadrien/c90927ec2d160ffea9c4)

## MIT License

Copyright (c) 2017 Impronta Advance srl

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
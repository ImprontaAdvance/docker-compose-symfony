# docker-compose for Symfony env

Out of the box symfony environment using docker-compose. It contains:
- PHP-FPM optimized
- nginx as web server
- MariaDB as mysql-like server
- XDebug (optional)
- GD libraries (optional)

After [setup](#setup), run `docker-compose up` and go to [localhost:8080](http://localhost:8080).

If `app` directory doesn't contain a Symfony app, a new one is created.

## Setup
Before build this image, copy `.env.dist` in `.env` and check configuration you want.

### .env parameters
- `DCSF_MYSQL=1` installs `pdo pdo_mysql` extensions
- `DCSF_XDEBUG=1` installs `xdebug` with `default_enable=1`
- `DCSF_XDEBUG_HOST` [see here](#xdebug)
- `DCSF_GD=1` installs `gd` extensions (for image manipulation)

These variables are used building time. If you want to enable/disable after first run, you have to rebuild it: `docker-compose build php`.

### XDebug
Inside docker container, the only way to communicate with xdebug is with static ip (ref. [xdebug/remote#communication](https://xdebug.org/docs/remote#communication)).

**Docker for Mac FOR MAC:** To make it work, you have to create an alias to your local IP: `sudo ifconfig lo0 alias 10.254.254.254`. Then put aliased IP to `.env` file:
```
DCSF_XDEBUG_HOST=10.254.254.254
```

**Linux platform:** To be tested
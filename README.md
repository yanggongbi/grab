# wordpress + sensu server

Wordpress (along with wp-cli) and Sensu monitoring platform in Docker

## Prerequisite

* `docker` and `docker-compose`

## Installation

```
git clone https://github.com/yanggongbi/grab.git
```

## Run

```
./run.sh
```

The entrypoing is _run.sh_, this shell script leverage docker compose and will bring up 5 containers:

1. **sensu-rabbitmq**: This is used as a transport for sensu. Sensu checks and results are published here.
2. **sensu-redis**: This is used as a data store for things such as client registry and check results.
3. **sensu-server**: This container will contain processes related to sensu (uchiwa, sensu-api, sensu-server).
4. **wordpress_app**: This container is wordpress application
5. **wordpress_mysql**: This container is wordpress backend database

## Access

### Wordpress

* `http://your-server`

### uchiwa

* `http://your-server:3000/`

The default user/pass are admin:admin.

### sensu API

* `http://your-server:4567/`

The default user/pass are admin:admin.

### known issues

* i do not have enough time to finish the whole monitoring stuff, the original plan was to startup a sensu client (with docker or not) and install the plugins.
* encountered some problems when do _docker exec_ against sensu server container in the shell script, i did some ugly fix in _start-uchiwa.sh_ but it does not do the trick, sometimes a `docker exec sensu-server /etc/init.d/uchiwa restart` is needed.

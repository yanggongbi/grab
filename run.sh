#!/bin/bash

# global vars
BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"
WPDIR="$BASEDIR/docker-wordpress"
SENSUDIR="$BASEDIR/docker-sensu-server"

wpConNum=2
sensuConNum=3
wpApp="wordpress_app"
wpDB="wordpress_mysql"
wpPath="/var/www/html"
sensuRedis="sensu-redis"
sensuRabbit="sensu-rabbitmq"
sensuServer="sensu-server"

function stop_wp() {
  echo "stopping wordpress containers..."
  cd $WPDIR && docker-compose down --volumes
}

function start_wp() {
  echo "staring the wordpress service..."
  cd $WPDIR && docker-compose up -d > ./wp_startup.log 2>&1
  if [ $? -eq 0 ]; then
    conCount=`docker ps |grep -E "$wpApp|$wpDB" |wc -l`
    if [ $conCount -eq $wpConNum ]; then
      echo "wordpress start successful"
    else
      echo "wordpress failed to start, check $WPDIR/startup.log"
      stop_wp
      exit 1
    fi
  else
    echo "wordpress failed to start, check $WPDIR/startup.log"
    stop_wp
    exit 1
  fi
}

function stop_sensu() {
  echo "stopping sensu server containers..."
  cd $SENSUDIR && docker-compose down --volumes
}

function start_sensu() {
  echo "staring the sensu server..."
  cd $SENSUDIR && docker-compose up -d > ./sensu_startup.log 2>&1
  if [ $? -eq 0 ]; then
    conCount=`docker ps |grep -E "$sensuRedis|$sensuRabbit|$sensuServer" |wc -l`
    if [ $conCount -eq $sensuConNum ]; then
      echo "sensu-server start successful"
      if [ -f "$SENSUDIR/start-uchiwa.sh" ]; then
        $SENSUDIR/start-uchiwa.sh
      fi
    else
      echo "sensu server failed to start, check $SENSUDIR/startup.log"
      stop_sensu
      exit 1
    fi
  else
    echo "sensu server failed to start, check $SENSUDIR/startup.log"
    stop_sensu
    exit 1
  fi  
}

function wp_install() {
  echo "start to install wordpress..."
  if [ -f "$WPDIR/wp-install.sh" ]; then
    $WPDIR/wp-install.sh
  fi
}

start_wp
wp_install
start_sensu

#!/bin/bash

function restart_uchiwa() {
  echo "restaring uchiwa..."
  docker exec sensu-server /etc/init.d/uchiwa restart
}

function stop_uchiwa() {
  uchiwa_pid=`docker exec sensu-server cat /var/run/uchiwa.pid` 2>/dev/null
  if [ -z $uchiwa_pid ]; then
    echo "uchiwa is not running"
    start_uchiwa
  else
    echo "killing uchiwa (pid: $uchiwa_pid)..."
    docker exec sensu-server kill -15 $uchiwa_pid
    sleep 5
    docker exec sensu-server /etc/init.d/uchiwa status && echo "stop uchiwa failed" || echo "stop uchiwa successful"
  fi
}

restart_uchiwa
stop_uchiwa
sleep 5
restart_uchiwa

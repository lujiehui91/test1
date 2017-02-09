#!/bin/bash
#
# /etc/init.d/marathon
#
# Startup script for marathon
#
# chkconfig: 2345 20 80
# description: Starts and stops marathon

prog="marathon"
mesosps="/home/mesos/marathon-0.6.0/bin/../target/scala-2.10/marathon-assembly-0.6.0.jar"
mesosBin="/home/mesos/marathon-0.6.0/bin/start"
desc="Marathon daemon"
outFile="/home/mesos/log/marathon/$prog.out"

start() {
  echo "Starting $desc ($prog): "
  su $mesosUser -c "nohup $mesosBin --master zk://192.168.1.147:2181,192.168.1.148:2181,192.168.1.149:2181/mesos --zk zk://192.168.1.147:2181,192.168.1.148:2181,192.168.1.149:2181/marathon >>$outFile 2>&1 &"

  RETVAL=$?
  return $RETVAL
}

stop() {
  echo "Shutting down $desc ($prog): "
  pkill -f $mesosps
}

restart() {
    stop
    start
}

status() {

  if [ -z $pid ]; then
     pid=$(pgrep -f $mesosps)

  fi


  if [ -z $pid ]; then
    echo "$prog is NOT running."
    return 1
  else
    echo "$prog is running (pid is $pid)."
  fi

}

case "$1" in
  start)   start;;
  stop)    stop;;
  restart) restart;;
  status)  status;;
  *)       echo "Usage: $0 {start|stop|restart|status}"
           RETVAL=2;;
esac
exit $RETVAL#!/usr/bin/env bash
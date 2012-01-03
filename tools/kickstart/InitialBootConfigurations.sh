#!/bin/sh
# Starts simple test
#


case "$1" in
start)
   mkdir /home/tmp
   whoami > /home/tmp/pwd.txt
   pwd >> /home/tmp/pwd.txt
   cat /home/tmp/pwd.txt

;;

*)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac


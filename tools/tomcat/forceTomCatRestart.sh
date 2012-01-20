#!/bin/bash
export TOMCAT_PROCESS='[t]omcat'
# ps aux | grep "$TOMCAT_PROCESS"
# ps aux | grep "$TOMCAT_PROCESS" | awk '{print $2}'
sudo kill $(ps aux | grep "$TOMCAT_PROCESS" | awk '{print $2}') 
sudo /etc/rc2.d/S99tomcat start


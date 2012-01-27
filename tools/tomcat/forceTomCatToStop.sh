#!/bin/bash
export TOMCAT_PROCESS='[t]omcat'
CNT=1
GENTLE_ONCE=1
ROUGH_ONCE=0
CROWBAR=20
while [ $CNT -gt 0 ]
do
	CNT=$(ps aux | grep -c "$TOMCAT_PROCESS")
	if [[ $GENTLE_ONCE > 0 ]]
	then
		GENTLE_ONCE=0
		echo "Asking TomCat to stop."
		sudo /etc/rc2.d/S99tomcat stop
	fi
	if [[ $ROUGH_ONCE > 0 ]]
	then
		ROUGH_ONCE=0
		echo "Processes :"
		ps aux | grep "$TOMCAT_PROCESS" | awk '{print $2}'
		echo "... are being terminated."
		sudo kill -9 $(ps aux | grep "$TOMCAT_PROCESS" | awk '{print $2}') 
	fi
	echo "Waiting $CROWBAR"
	let "CROWBAR -= 1"
	if [[ $CROWBAR == 10 ]]; then ROUGH_ONCE=1; fi
	if [[ $CROWBAR < 1 ]]; then break; fi
	sleep 6
done
#


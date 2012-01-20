#!/bin/bash
export TOMCAT_PROCESS='[t]omcat'
CNT=1
ONCE=1
CROWBAR=10
while [ $CNT -gt 0 ]
do
	CNT=$(ps aux | grep -c "$TOMCAT_PROCESS")
	if [[ $ONCE > 0 ]]
	then
		echo "Processes :"
		ps aux | grep "$TOMCAT_PROCESS" | awk '{print $2}'
		echo "... are being terminated."
		sudo kill $(ps aux | grep "$TOMCAT_PROCESS" | awk '{print $2}') 
		ONCE=0
	fi
	echo "Waiting $CROWBAR"
	let "CROWBAR -= 1"
	if [ $CROWBAR -lt 1 ]; then break; fi
	sleep 6
done
#
echo "Starting TomCat."
sudo /etc/rc2.d/S99tomcat start
echo "Done."


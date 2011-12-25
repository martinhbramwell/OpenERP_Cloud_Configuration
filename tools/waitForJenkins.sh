#!/bin/bash
idx=0
rslt=0
while [ $idx -lt 10 ]
do
  rslt=$(curl -sI http://jenkins.warehouseman.com/jenkins/ | grep -c X-Jenkins: )
  if [ ${rslt} == 1 ]
  then
    exit 0
  fi

  echo -n "Waiting for Jenkins to start (${idx})."
  let "idx += 1"
  sleep 3

done

exit 1




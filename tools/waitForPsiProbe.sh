#!/bin/bash
idx=0
rslt=0
while [ $idx -lt 10 ]
do
  rslt=$(curl -sI http://jenkins.warehouseman.com/probe | grep -c X-Jenkins: )
  if [ ${rslt} == 1 ]
  then
    exit 0
  fi

  let "idx += 1"
  echo -n "Waiting for Psi Probe to start (${idx})."
  sleep 3

done

exit 1




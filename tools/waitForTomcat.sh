#!/bin/bash
idx=0
rslt=0
while [ $idx -lt 10 ]
do
  rslt=$(curl -sI http://jenkins.warehouseman.com/ | grep -c X-Jenkins: )
  if [ ${rslt} == 1 ]
  then
    exit 0
  fi

  echo -ne "Waiting for TomCat to start (${idx}).\033[25C"
  let "idx += 1"
  sleep 3

done

exit 1




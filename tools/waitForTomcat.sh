#!/bin/bash

SERVICE="TomCat"
service="tomcat"
expect="HTTP/1.1 200 OK"

idx=0
rslt=0
while [ $idx -lt 10 ]
do
  rslt=$(curl -sI http://localhost/ | grep -c "${expect}" )
  if [ ${rslt} == 1 ]
  then
    echo "${SERVICE} is up and running,                                            "
    exit 0
  fi

  echo -ne "Waiting for ${SERVICE} to start (${idx}).\033[100D"
  let "idx += 1"
  sleep 3

done

echo "Got no answer from ${SERVICE}.                                                     "

exit 1





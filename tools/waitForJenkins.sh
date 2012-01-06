#!/bin/bash

SERVICE="Jenkins"
command="jenkins/reload"
response="Please wait while Jenkins is getting ready to work"
service="jenkins/"
expect="Please <a href=\"newJob\">create new jobs</a> to get started."

outer=0
inner=0
rslt=0
while [ $outer -lt 2 ]
do
   curl -s "http://localhost/${command}" | grep "${response}"
   while [ $inner -lt 5 ]
   do
     rslt=$(curl -s "http://localhost/${service}" | grep -c "${expect}" )

     if [ ${rslt} == 1 ]
     then
       echo "${SERVICE} is up and running,                                                   "
       exit 0
     fi

     echo -ne "Waiting for ${SERVICE} to start (${idx}).\033[100D"
     let "inner += 1"
     sleep 3

   done
   let "outer += 1"
done

echo "Got no answer from ${SERVICE}.                                                     "

exit 1




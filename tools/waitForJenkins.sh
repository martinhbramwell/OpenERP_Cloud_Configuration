#!/bin/bash

SERVICE="Jenkins"
command="jenkins/reload"
response="Please wait while Jenkins is getting ready to work"
service="jenkins/"
expect1="Manage Jenkins"
expect2="Please <a href=\"newJob\">create new jobs</a> to get started."

outer=0
inner=0
rslt1=0
rslt2=0
idx=0
while [ $outer -lt 2 ]
do
   curl -s "http://localhost/${command}" | grep "${response}"
   while [ $inner -lt 5 ]
   do
     rslt1=$(curl -s "http://localhost/${service}" | grep -c "${expect1}" )
     rslt2=$(curl -s "http://localhost/${service}" | grep -c "${expect2}" )

     if [ (${rslt1} == 1) || (${rslt2} == 1) ]
     then
       echo "${SERVICE} is up and running,                                                   "
       exit 0
     fi

     echo -ne "Waiting for ${SERVICE} to start (${idx}).\033[100D"
     let "idx += 1"
     let "inner += 1"
     sleep 3

   done
   let "outer += 1"
done

echo "Got no answer from ${SERVICE}.                                                     "

exit 1



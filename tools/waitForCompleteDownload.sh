#!/bin/bash

DELAY=-1
LOG_FILE_NAME=""
SEARCH_PATTERN=""

#  Input validations
function giveHelp {
   
   echo "Usage: $0 -d DELAY -l LOG_FILE_NAME -p SEARCH_PATTERN"
   echo " - -d number of seconds to wait"
   echo " - -l name of wget log file"
   echo " - -p search pattern in log file"
   exit
}

if [ $# -lt 3 ] ; then
  giveHelp
  exit 1
fi 
#
while [ $# -gt 1 ] ; do
  case $1 in
    -d) DELAY=$2 ; shift 2 ;;
    -l) LOG_FILE_NAME=$2 ; shift 2 ;;
    -p) SEARCH_PATTERN=$2 ; shift 2 ;;
    *) shift 1 ;;
  esac
done
#
if ! echo ${DELAY} | sed 's/-//' | grep "^[0-9]*$">/dev/null; then DELAY=-1; fi
if [ ${DELAY} -lt 1 ] || [ "X${LOG_FILE_NAME}" == "X" ] || [ "X${SEARCH_PATTERN}" == "X" ]; then
  giveHelp && exit 1
fi
#
[ ! -f ${LOG_FILE_NAME} ] && echo "${LOG_FILE_NAME} : File not found!" && exit 1

echo Found -d ${DELAY} -l ${LOG_FILE_NAME} -p ${SEARCH_PATTERN}
#exit 1

# Input validated

idx=0
rslt=0
while [ $idx -lt ${DELAY} ]
do
#  echo [1]
  rslt=$( cat ${LOG_FILE_NAME} | grep -c "${srch}[0-9A-Za-z'\.\-]* saved"   )
  if [ ${rslt} -gt 2 ]
  then
    echo "${SEARCH_PATTERN} arrived after ${idx} seconds.                                            "
    exit 0
  fi

  echo -ne "Waiting for ${SEARCH_PATTERN} download to complete (${idx}).\033[100D"
  let "idx += 1"
  sleep 1

done

echo "${SEARCH_PATTERN} did not complete in ${DELAY} seconds.                                                     "

echo [2]
echo [3]

exit 1



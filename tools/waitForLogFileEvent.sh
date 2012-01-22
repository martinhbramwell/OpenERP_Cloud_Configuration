#!/bin/bash
# Script to collect prepare an empty Jenkins server with an empty Fitnesse wiki.
#

DELAY=-1
LOG_FILE_NAME=""
SUCCESS_PATTERN=""
FAIL_PATTERN=""

#  Input validations
function giveHelp {
   
   echo "Usage: $0 -d DELAY -l LOG_FILE_NAME -s SUCCESS_PATTERN -f FAIL_PATTERN"
   echo " - -d number of seconds to wait"
   echo " - -l name of wget log file"
   echo " - -s success pattern in log file"
   echo " - -f failure pattern in log file"
   echo ""
   echo "returns : 0 = success, >0 = fail"
   exit
}

if [ $# -lt 4 ] ; then
  giveHelp
  exit 1
fi 
#
while [ $# -gt 1 ] ; do
  case $1 in
    -d) DELAY=$2 ; shift 2 ;;
    -l) LOG_FILE_NAME=$2 ; shift 2 ;;
    -s) SUCCESS_PATTERN=$2 ; shift 2 ;;
    -f) FAIL_PATTERN=$2 ; shift 2 ;;
    *) shift 1 ;;
  esac
done
#
if ! echo ${DELAY} | sed 's/-//' | grep "^[0-9]*$">/dev/null; then DELAY=-1; fi
#
if [ ${DELAY} -lt 1 ] || [ "X${LOG_FILE_NAME}" == "X" ] || [ "X${SUCCESS_PATTERN}" == "X" ] || [ "X${FAIL_PATTERN}" == "X" ]; then
  echo "Got -d ${DELAY} -l ${LOG_FILE_NAME} -s ${SUCCESS_PATTERN} -f ${FAIL_PATTERN}" && giveHelp && exit 1
fi
#
[ ! -f ${LOG_FILE_NAME} ] && echo "${LOG_FILE_NAME} : File not found!" && exit 1

echo Will wait ${DELAY} seconds for either \"${SUCCESS_PATTERN}\" or \"${FAIL_PATTERN}\" to appear in ${LOG_FILE_NAME}.
echo ""
#exit 1

# Input validated

idx=0
rslt=0
while [ $idx -lt ${DELAY} ]
do
  rslt=$(  tail -n 4 ${LOG_FILE_NAME} | egrep -c "${FAIL_PATTERN}"   )
  if [ ${rslt} -gt 0 ]
  then
    tail -n 4 ${LOG_FILE_NAME}
    exit 0
  fi

#  rslt=$( tail -n 4 ${LOG_FILE_NAME} | grep -c "ERROR"   )
#  if [ ${rslt} -gt 0 ]
#  then
#    tail -n 4 ${LOG_FILE_NAME}
#    exit 0
#  fi

  rslt=$( cat ${LOG_FILE_NAME} | egrep -c "${SUCCESS_PATTERN}"   )

  if [ ${rslt} -eq 1 ]
  then
    echo "Event ...                                                                          "
    cat ${LOG_FILE_NAME} | egrep "${SUCCESS_PATTERN}"
    echo "... flagged after ${idx} seconds.                                            "
    exit 0
  fi

  echo -ne ".\033[1A\033[100D "
  echo -ne "Waiting for ${SUCCESS_PATTERN} download to complete (${idx})"
  echo " "
  let "idx += 1"
  sleep 1

done

echo "${SUCCESS_PATTERN} did not complete in ${DELAY} seconds.                                                     "

exit 1

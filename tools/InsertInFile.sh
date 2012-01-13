#!/bin/bash
#  This script expects a search pattern, a replacement pattern and a source file.
# It appends .new to create an output file.

SEARCH_PATTERN=""
FILE_NAME=""
INSERTION_PATTERN=""

#  Input validations
function giveHelp {
   
   echo "Usage: $0 -s search_text -r insertion_text -f file"
   echo " - -s a pattern to find"
   echo " - -i text to insert *before* search pattern"
   echo " - -f file to update"
   echo " Example :"
   echo "INSERTION='    Button \{\n            id=aLauncher.desktop\n        }\n    '"
   echo "EOF_MARKER=\"\}\""
   echo "FILE=someFile.txt"
   echo "./InsertInFile.sh -i \"\${INSERTION}\" -s \"\${EOF_MARKER}\" -f \${FILE}"
   exit
}

if [ $# -lt 3 ] ; then
  giveHelp
  exit 1
fi 
#
#
while [ $# -gt 1 ] ; do
  case $1 in
    -i) INSERTION_PATTERN=$2 ; shift 2 ;;
    -f) FILE_NAME=$2 ; shift 2 ;;
    -s) SEARCH_PATTERN=$2 ; shift 2 ;;
    *) shift 1 ;;
  esac
done
#
FAIL=
[ "X${FILE_NAME}" == "X" ] && echo "A file name must be provided!" && FAIL=true
[ "X${SEARCH_PATTERN}" == "X" ] && echo "A search pattern must be provided!" && FAIL=true
[ "X${INSERTION_PATTERN}" == "X" ] && echo "An insertion value must be provided!" && FAIL=true
[ ${FAIL} ] && giveHelp && exit 1
[ ! -f ${FILE_NAME} ] && echo "${FILE_NAME} : File not found!" && exit 1

echo Will insert ${INSERTION_PATTERN} before ${SEARCH_PATTERN} in ${FILE_NAME}.
echo ""
#exit 1

# Input validated
# echo "-----------------------------------------------------------"
# cat ${FILE_NAME}
# echo "-----------------------------------------------------------"
# SEARCH_PATTERN = "    \}"
# INSERTION_PATTERN = "        Button {\n            Q_Q\n        \}\n"
#sed "/\}/{
sed "/$SEARCH_PATTERN$/{
N
s|$SEARCH_PATTERN$|$INSERTION_PATTERN$SEARCH_PATTERN|g
}" <${FILE_NAME} >${FILE_NAME}.new
# cat ${FILE_NAME}.new
# echo "-----------------------------------------------------------"


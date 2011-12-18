#!/bin/bash        
#
# Begin
# Get other name if not default to backup.
#
echo Default database is ${MyDatabaseName}
echo -n "Is that the database you want to destroy and replace with an earlier version? [y/n]"
read -esn 1 restoreDefault
if [ ${restoreDefault} == "n" ]; then
	echo -n "Type in the name of the database you wish to backup : "
	read -e DB
	local MyDatabaseName=${DB}
fi
#
local prefix="OpenERP_"
local separator="_"
local bkYear="11"
local bkMonth="12"
local bkDay="17"
local bkHour="14"
local bkMin="34"
local suffix=".backup"
#
local oldArchive=${prefix}${MyDatabaseName}${separator}${bkYear}${bkMonth}${bkDay}${bkHour}${bkMin}${suffix}
#
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
local choice=-1
local someOtherName=0
local promptIs=""
local promptLen=-1
while [ ${choice} != 0 ]; do

	if [ ${someOtherName} == 0 ]; then
		oldArchive=${prefix}${MyDatabaseName}${separator}${bkYear}${bkMonth}${bkDay}${bkHour}${bkMin}${suffix}
	fi

	echo -en "\033[14A----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.----"
	echo ""
	echo "1) Prefix : ${prefix}"
	echo "2) Separator : ${separator}"
	echo "3) Year : ${bkYear}"
	echo "4) Month : ${bkMonth}"
	echo "5) Day : ${bkDay}"
	echo "6) Hour : ${bkHour}"
	echo "7) Min : ${bkMin}"
	echo "8) Suffix : ${suffix}"
	echo "9) Some other name completely"
	echo "0) It's correct now"
	echo "Type a number to indicate which element you want to edit:"
	echo "----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.----"

	promptIs="Ready to restore the file [${oldArchive}]. Choice : "  
   promptLen=$((${#promptIs}))

	echo -n ${promptIs} " " 
	read -en 1 choice
	echo -en "\033[1A\033[${promptLen}C"

	someOtherName=0

	case ${choice} in
	    1*)
			echo -n ") Prefix : "
			read -e prefix
	        ;;
	    2*)
			echo -n "2) Separator : "
			read -e separator
	        ;;
	    3*)
			echo -n "3) Year : "
			read -e bkYear
	        ;;
	    4*)
			echo -n "4) Month : "
			read -e bkMonth
	        ;;
	    5*)
			echo -n "5) Day : "
			read -e bkDay
	        ;;
	    6*)
			echo -n "6) Hour : "
			read -e bkHour
	        ;;
	    7*)
			echo -n "7) Min : "
			read -e bkMin
	        ;;
	    8*)
			echo -n "8) Suffix : "
			read -e suffix
	        ;;
	    9*)
			echo -n "9) Some other name completely : "
			read -e oldArchive
			someOtherName=1
			echo -e "\033[0A                                                                                ]"
	        ;;
	    *)
			echo -n "Huh?"
	        ;;
	esac
	echo -en "\033[1A\033[${promptLen}C                                             "
	
done

echo -n "We're ready to do this.  Are you absolutely certain about replacing the contents of ${MyDatabaseName} with the backup file ${oldArchive}? [no/yes]"
read -e confirmation
if [ ${confirmation} == "yes" ]; then
	echo -n "Ple"
	exit
fi


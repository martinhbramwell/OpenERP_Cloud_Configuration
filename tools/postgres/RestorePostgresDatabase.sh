#!/bin/bash        
#
# Begin
# Get other name if not default to backup.
#
backUpDir="databaseBackups"
#
echo Default database is ${MyDatabaseName}
echo -n "Is that the database you want to destroy and replace with an earlier version? [y/n] "
read -esn 1 restoreDefault
if [ ${restoreDefault} == "n" ]; then
	echo -n "Type in the name of the database you wish to backup : "
	read -e DB
	MyDatabaseName=${DB}
fi
#
echo " "
ls -l ~/${backUpDir}/
echo " "
echo -n " "
#
prefix="OpenERP_"
separator="_"
bkYear=$(date +%y)
bkMonth=$(date +%m)
bkDay=$(date +%d)
bkHour=$(date +%H)
bkMin=$(date +%M)
suffix=".backup"
#
oldArchive=${prefix}${MyDatabaseName}${separator}${bkYear}${bkMonth}${bkDay}${bkHour}${bkMin}${suffix}
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
echo " "
echo " "
echo " "
echo " "
underscore="\033[0C----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.----"

choice=-1
someOtherName=0
promptIs=""
promptLen=-1
non="X"
RED="\033[0;31m"
NO_COLOUR="\033[0m"

while [ ${choice} != 0 ]; do

	if [ ${someOtherName} == 0 ]; then
		oldArchive=${prefix}${MyDatabaseName}${separator}${bkYear}${bkMonth}${bkDay}${bkHour}${bkMin}${suffix}
	fi

	ls -l ~/${backUpDir}/${oldArchive}  &> /dev/null
	rslt=$?
	if [ ${rslt} == 0 ]; then
		non="pre-existing"
	else
		non="${RED}NON-existent${NO_COLOUR}"
	fi


	echo ""

	echo -en "\033[14A${underscore}"
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
	echo -e "${underscore}"
	echo "Type a number to indicate which element you want to edit:"
	promptIs="Ready to restore the ${non} file [${oldArchive}]. Choice : "  
   promptLen=$((${#promptIs}))

	echo -en ${promptIs} " " 
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
			read -en 2 bkYear
	        ;;
	    4*)
			echo -n "4) Month : "
			read -en 2 bkMonth
	        ;;
	    5*)
			echo -n "5) Day : "
			read -en 2 bkDay
	        ;;
	    6*)
			echo -n "6) Hour : "
			read -en 2 bkHour
	        ;;
	    7*)
			echo -n "7) Min : "
			read -en 2 bkMin
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
	    0*)
			echo -en "Done."
	        ;;
	    *)
			echo -n "Huh?"
	        ;;
	esac
	echo -en "\033[1A\033[${promptLen}C                      "
	
done

echo -n "                                                                              "
echo ""
echo "We're ready to do this."
echo -e "Are you ${RED}absolutely${NO_COLOUR} certain about replacing the contents of "
echo "                 ${MyDatabaseName} "
echo "... with the backup file..."
echo "                 ${oldArchive}"
echo -n "     [no/yes] "
read -e confirmation
#
if [ ${confirmation} == "yes" ]; then
	echo "Restoring ${oldArchive} into ${MyDatabaseName}."
	pg_restore -c -Fc -d ${MyDatabaseName} -U ${MyDatabaseUserName}  -h ${MyDatabaseHost} -p ${MyDatabasePortNumber} ~/databaseBackups/${oldArchive}
fi


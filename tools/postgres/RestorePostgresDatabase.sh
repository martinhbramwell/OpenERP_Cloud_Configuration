#!/bin/bash        
#
# Begin
# Get other name if not default to backup.
#
backUpDir="databaseBackups"
#
echo Default database is ${MyDatabaseName}
OldDatabaseName=${MyDatabaseName}
NewDatabaseName=${MyDatabaseName}
echo -n "Is that the database you want to destroy and replace with an earlier version? [y/n] "
read -esn 1 restoreDefault
if [ ${restoreDefault} != "y" ]; then
	echo -n "Type in the name of the database you wish to backup : "
	read -e DB
	NewDatabaseName=${DB}
fi
#
echo " "
whoami=`whoami`
BACKUPS=`ls ~/${backUpDir}/*`
idx=0
Files[${idx}]=""
#
for backup in ${BACKUPS} ;
do
	idx=$((1 + ${idx}))
	echo " - ${idx}) - ${backup}"
	Files[${idx}]=${backup}
done

echo " "
echo -n " "
#
prefix="OpenERP_"
separator="_"
bkYearMonth=$(date +%y%m)
bkDay=$(date +%d)
bkHourMin=$(date +%H%M)
suffix=".backup"
pick=1
#
oldArchive=${prefix}${OldDatabaseName}${separator}${bkYearMonth}${bkDay}${bkHourMin}${suffix}
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
echo " "
echo " "
echo " "
echo " "
underscore="\033[0C----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.---- ----.----"

PrefixTitle="Prefix"
SeparatorTitle="Separator"
YearAndMonthTitle="Year & Month"
DayTitle="Day"
HourAndMinTitle="Hour & Min"
DatabaseTitle="Database"
SuffixTitle="Suffix"
PickFromListAboveTitle="Pick from list above"
SomeOtherNameCompletelyTitle="Some other name completely"
ItsCorrectNowTitle="It's correct now"


filePicked=""
choice=-1
someOtherName=0
promptIs=""
promptLen=-1
non="X"
RED="\033[0;31m"
NO_COLOUR="\033[0m"

while [ ${choice} != 0 ]; do

	if [ ${someOtherName} == 0 ]; then
		oldArchive="/home/${whoami}/${backUpDir}/${prefix}${OldDatabaseName}${separator}${bkYearMonth}${bkDay}${bkHourMin}${suffix}"
	fi

	ls -l ${oldArchive}  &> /dev/null
	rslt=$?
	if [ ${rslt} == 0 ]; then
		non="pre-existing"
	else
		non="${RED}NON-existent${NO_COLOUR}"
	fi


	echo ""




	echo -en "\033[16A${underscore}"
	echo ""
	echo "1) ${PrefixTitle} : ${prefix}                                 	"
	echo "2) ${SeparatorTitle} : ${separator}                            "
	echo "3) ${YearAndMonthTitle} : ${bkYearMonth}"
	echo "4) ${DayTitle} : ${bkDay}"
	echo "5) ${HourAndMinTitle} : ${bkHourMin}"
	echo "6) ${DatabaseTitle} : ${OldDatabaseName}                       "
	echo "7) ${SuffixTitle} : ${suffix}                                  "
	echo "8) ${PickFromListAboveTitle} : ${pick} ${filePicked}"
	echo "9) ${SomeOtherNameCompletelyTitle}                                             "
	echo "0) ${ItsCorrectNowTitle}"
	echo -e "${underscore}"
	echo "Type a number to indicate which element you want to edit:"
	promptIs="Ready to restore the ${non} file [${oldArchive}]. "  
   promptLen=$((${#promptIs}))

	echo "                                                                                "
	echo -e "\033[2A${promptIs}                                                  " 
	echo -ne "Choice : " 
	read -en 1 choice
	echo "                                                                                "
	echo -en "\033[2A\033[10C"


	someOtherName=0

	case ${choice} in
	   1*)
			echo -n ") ${PrefixTitle} : "
			read -e prefix
	        ;;
	   2*)
			echo -n ") ${SeparatorTitle} : "
			read -e separator
	        ;;
	   3*)
			echo -n ") ${YearAndMonthTitle} : "
			read -en 4 bkYearMonth
	        ;;
	   4*)
			echo -n ") ${DayTitle} : "
			read -en 2 bkDay
	        ;;
	   5*)
			echo -n ") ${HourAndMinTitle} : "
			read -en 4 bkHourMin
	        ;;
	   6*)
			echo -n ") ${DatabaseTitle} : "
			read -en 2 bkMin
	        ;;
	   7*)
			echo -n ") ${SuffixTitle} : "
			read -e suffix
	        ;;
		8*)
			echo -n ") ${PickFromListAboveTitle} : "
			read -en 3 pick
			someOtherName=1
			oldArchive=${Files[${pick}]}
	        ;;
	   9*)
			echo -n ") ${SomeOtherNameCompletelyTitle} : "
			read -e oldArchive
			someOtherName=1
			echo -e "\033[0A                                                                                ]"
	        ;;
		0*)
			echo -en "${ItsCorrectNowTitle}."
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
echo "                 ${NewDatabaseName} "
echo "... with the backup file..."
echo "                 ${oldArchive}"
echo -n "     [no/yes] "
read -e confirmation
#
if [ ${confirmation} == "yes" ]; then
	echo "Restoring ${oldArchive} into ${NewDatabaseName}."
	pg_restore -c -Fc -d ${NewDatabaseName} -U ${MyDatabaseUserName}  -h ${MyDatabaseHost} -p ${MyDatabasePortNumber} ${oldArchive}
fi


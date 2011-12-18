#!/bin/bash        
#
# Begin
# Now we want to create a new database without being sure if one is there already.
#
if [ -z "$1" ]; then 
	echo -n "Type in the name of the database you wish to create : "
	read -e DB
else
	DB=$1
fi
#
My_New_DatabaseName=${DB}
#
psql -U ${MyDatabaseUserName}  -h ${MyDatabaseHost} -p ${MyDatabasePortNumber} -d ${My_New_DatabaseName} -c "\q" &> /dev/null
rslt=$?

create=0
if [ ${rslt} == 0 ]; then
   echo "Database exists. Do you wish to kill ${My_New_DatabaseName} and make a new one? [y/n]"
	read -es killIt
	if [ ${killIt} == "y" ]; then
		create=1
	fi
else
   echo Database ${My_New_DatabaseName} does not exist.
	create=1
fi

if [ ${create} == 1 ]; then
	#
	# (Check that you get : "Creating new database : Your_NEW_Database_Name")
	echo Killing : ${My_New_DatabaseName}
	#
	# Let's get rid of the old one first, if there.  If not, ignore the warning.
	dropdb -U ${MyDatabaseUserName}  -h ${MyDatabaseHost} -p ${MyDatabasePortNumber} ${My_New_DatabaseName}  &> /dev/null
	#
	# Now we can create the database
	# (Check that you get : 'CREATE DATABASE "Your_NEW_Database_Name" TEMPLATE template0;')
	echo Creating : ${My_New_DatabaseName}
	createdb -e -U ${MyDatabaseUserName}  -h ${MyDatabaseHost} -p ${MyDatabasePortNumber} -T template0 ${My_New_DatabaseName}
	# We now have a new empty database into which we can restore the backup we made earlier.
	#
fi


#!/bin/bash        
#
# Begin
# Get other name if not default to backup.
#
echo Default database is ${MyDatabaseName}
echo "Back it up? [y/n]"
read -es backUpDefault
if [ ${backUpDefault} == "n" ]; then
	echo -n "Type in the name of the database you wish to backup : "
	read -e DB
	MyDatabaseName=${DB}
fi
#
#
# Begin
# Now we can run our back up command
cd ~/
pg_dump ${MyDatabaseName} -v -Fc -U ${MyDatabaseUserName} -h ${MyDatabaseHost} -p ${MyDatabasePortNumber} > ./databaseBackups/OpenERP_${MyDatabaseName}_$(date +%y%m%d%H%M).backup
# (Check that you got many dozens of lines like : "pg_dump: dumping contents of table some_table_name")
#
# Now check the backups directory ...
# (Check that you get : "-rw-r--r-- 1 yourUserID yourGroup nn yr-mt-dy hr:mn OpenERP_YourDatabaseName_yrmtdyhrmn.backup")
ls -l ./databaseBackups/
#
# You now have a back up file.
#   *** Run it again and you'll have two backup files ***
# Done
#

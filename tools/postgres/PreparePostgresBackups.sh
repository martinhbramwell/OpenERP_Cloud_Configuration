    # Begin
    # Go to our home directory
    # (Check that you get : /home/yourUserID)
    cd ~/
    pwd
    # First we need a directory in which to keep our backup files ...
    mkdir -p ~/databaseBackups
    # (Check that you get : drwxr-xr-x 2 yourUserID yourGroup nn yr-mt-dy hr:mn databaseBackups)
    ls -dl da*
    # We'll be running our commands from our home directory but the activity will be in "databaseBackups"
    #
    # Next step :
    # Since we don't want to have to type the database details each time we set up substitution variables...
    # Please use your own details as indicated
    # eg; where it says "export MyDatabasePortNumber=TypeYourDatabasePortNumberHere" you should
    # replace it with something like "export MyDatabasePortNumber=5432"
#
export MyDatabaseName=esrd
export MyDatabaseHost=openerpdbs.warehouseman.com
export MyDatabaseUserName=postgres
export MyDatabasePassword=whorehouseman
export MyDatabasePortNumber=5432
#
    # (Check that you get : YourDatabaseHost:YourDatabasePortNumber:YourDatabaseName:YourDatabaseUserName:YourDatabasePassword)
    echo ${MyDatabaseHost}:${MyDatabasePortNumber}:${MyDatabaseName}:${MyDatabaseUserName}:${MyDatabasePassword}
    #
    # Next we want to create a private password file
    cat > .pgpass  <<EOF
    ${MyDatabaseHost}:${MyDatabasePortNumber}:*:${MyDatabaseUserName}:${MyDatabasePassword}
    EOF
    # Did that worked as expected?
    # (Check that you get : YourDatabaseHost:YourDatabasePortNumber:*:YourDatabaseUserName:YourDatabasePassword)
    cat .pgpass
    # ... but, even so, Postgres will ignore it if it isn't really private, so :
    chmod 600 .pgpass
    # The -rw------- means only you can read and write it.
    # (Check that you get : -rw------- 1 yourUserID yourGroup nn yr-mt-dy hr:mn .pgpass)
    ls -la .pgpass
    #
    #
    # End 

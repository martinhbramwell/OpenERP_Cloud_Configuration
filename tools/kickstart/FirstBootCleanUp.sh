echo "Clean up."
cd $ADMIN_USERZ_HOME/

echo "Work dir"
rm -fr $ADMIN_USERZ_WORK_DIR/

echo "Deactivate rc2 script"
cd /etc/rc2.d/
rm -f S99xibc

echo "Can we see it? $CAN_WE_SEE_THIS_INSIDE_THE_SCRIPTS"

###########   reboot now


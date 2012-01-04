echo "Clean up."
cd $ADMIN_USERZ_HOME/
rm -fr $ADMIN_USERZ_WORK_DIR/

rm -f /etc/rc2.d/S99xibc

echo "Can we see it? $CAN_WE_SEE_THIS_INSIDE_THE_SCRIPTS"

###########   reboot now


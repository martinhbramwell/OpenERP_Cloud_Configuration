
echo "- - - - - - - - - - - - - - - - - - - - "


echo "Destroying old image"
rm -fr $TARGET

echo "Creating new ISO image"
cd $WORKING_IMAGE
mkisofs -D -r -V "$DSK_LABEL" -cache-inodes -J -l -b $IMG_NAME -c $IMG_CAT \
  -no-emul-boot -boot-load-size 4 -boot-info-table -o $TARGET .

if [ -f "$TARGET" ]; then
   echo "*** $TARGET Successfully Recorded ***"
else
   echo "*** $TARGET Writing Failed ***";
   exit 1;
fi

echo "= = = = = = = = = = = = = = = = = = = = "


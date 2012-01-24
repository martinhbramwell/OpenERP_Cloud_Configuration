echo "In bbb"
#
DEST_DIR=".."
DEST_TASK="./required_variables.sh"
pushd ${DEST_DIR} > /dev/null; source ${DEST_TASK}; popd  > /dev/null;
#
BBB="BXBXBX"
echo "In bbb : ${BBB}"


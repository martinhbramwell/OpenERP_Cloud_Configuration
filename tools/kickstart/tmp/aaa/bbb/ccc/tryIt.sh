echo "In tryIt."
source ./required_variables.sh
echo "From tryIt : ${AAA}"
echo "From tryIt : ${BBB}"
echo "From tryIt : ${CCC}"
pwd
DEST_DIR="../../bbc/ccx"
DEST_TASK="./tryMe.sh"
pushd ${DEST_DIR} > /dev/null; source ${DEST_TASK}; popd  > /dev/null;
echo "From tryIt : ${BBBx}"
echo "From tryIt : ${CCCx}"


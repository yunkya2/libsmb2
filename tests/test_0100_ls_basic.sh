#!/bin/sh

. ./functions.sh

echo "basic ls test"

echo -n "Testing prog_ls on root of share ... "
../utils/smb2-ls "${TESTURL}/" > /dev/null || failure
success

echo -n "Testing prog_ls on a directory that does not exist ... "
./prog_rmdir "${TESTURL}/testdir" > /dev/null
../utils/smb2-ls "${TESTURL}/testdir" >/dev/null && failure
success

echo -n "Testing prog_ls on a directory that does exist ... "
./prog_mkdir "${TESTURL}/testdir" > /dev/null
../utils/smb2-ls "${TESTURL}/testdir" >/dev/null || failure
./prog_rmdir "${TESTURL}/testdir" > /dev/null
success

exit 0
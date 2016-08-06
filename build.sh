#!/bin/bash
#
# Syncs the source and builds it.

cd /root/source

ccache -M 150
echo "ccache limit set to 150GB"

echo "Syncing source..."
time repo sync -c --force-broken --force-sync --no-clone-bundle

source build/envsetup.sh

lunch cm_${DEVICE}-userdebug && time mka bacon 2>&1 | tee $logfile

if [ $? -eq 0 ]; then
	printf "Build Suceeded\n";
else
	printf "Build failed\n";
	exit 1;
fi

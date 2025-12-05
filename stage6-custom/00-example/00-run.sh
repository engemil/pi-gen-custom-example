#!/bin/bash -e

log "Test 00-run.sh 1"
echo "Test 00-run.sh 2"

mkdir -p "${ROOTFS_DIR}/opt/customtest"
cp -r files/* "${ROOTFS_DIR}/opt/custom/test"



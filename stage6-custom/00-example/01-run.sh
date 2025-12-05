#!/bin/bash -e

log "Test 00-run.sh 1"
echo "Test 00-run.sh 2"

on_chroot <<- EOF
    echo "Test on_chroot"
    useradd -m customuser
EOF

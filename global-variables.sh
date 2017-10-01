#!/bin/bash

backupLocation=$1
typeset -r backupLocation

echo "Backup Location: $backupLocation"

echo
echo Any attempts to change this value will fail
echo

backupLocation='new-location'


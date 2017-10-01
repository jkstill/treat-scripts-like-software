#!/bin/bash

dirToDeletePath='/u01/app/oracle'

dirToDeleteLocation=$1

dirToDeleteFullPath=${dirToDeletePath}/${dirToDeleteLocation}

delCmd='echo Removing: '

echo
$delCmd $dirToDeleteFullPath
echo




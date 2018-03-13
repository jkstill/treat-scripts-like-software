#!/bin/bash

function hardpath {

   typeset ProgName ProgPath ProgVar
   ProgName=$1
   ProgVar=$2
   typeset idx=0
   typeset DIRS

   for path in /etc /bin /sbin /usr/bin /usr/local/bin $HOME~/bin
   do
      DIRS[$idx]=$path
      (( idx = idx + 1))
   done
   
   idx=0
   typeset foundit
   foundit=0
   
   while (( foundit < 1 ))
   do
      [ -x "${DIRS[$idx]}/$ProgName" ] && {
         ProgPath=${DIRS[$idx]}/$ProgName
         foundit=1
      }
      (( idx = idx+1 ))
   done
   
   # is file executable?
   [ -x "$ProgPath" ] || {
      echo "$ProgName - $ProgPath is not executable"
      exit 1
   }

   eval "$ProgVar=$ProgPath"
}

hardpath ls LS

echo '$LS: ' $LS


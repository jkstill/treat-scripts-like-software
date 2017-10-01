#!/bin/bash

typeset -r myMessage='this is a read only Global Variable'

# trap exits from parameter tests
trap "usage 'missing command line parameters';exit 1" 0

usage ()  {
	typeset errmsg="$*"
	typeset -r scriptName=$(basename $0)
	echo
	echo "error detected in $scriptName: $errmsg"
	echo 
	echo "usage: $scriptName -a ARG_A -b ARG_B -c ARG_C"
	echo
}

ARG_A=''
ARG_B=''
ARG_C='DEFAULT'

#set -v

while getopts a:b:c: arg
do
	case $arg in
		a) ARG_A=$OPTARG
			echo A: $ARG_A;;
		b) ARG_B=$OPTARG
			echo B: $ARG_B;;
		c) ARG_C=$OPTARG
			echo C: $ARG_C;;
		*) echo "invalid argument specified"; usage;exit 1;
	esac

done

# if any of vars are null, this test will exit
: ${ARG_A:?} ${ARG_B:?} ${ARG_C:?} 

# turn off the trap
trap 0

myMessage='changeMe'

echo "myMessage: $myMessage"

echo
echo '========================'
echo A: $ARG_A
echo B: $ARG_B
echo C: $ARG_C



#!/bin/bash

configFile=config_demo.conf

[[ -r $configFile ]] || {
	echo 
	echo Config file $configFile is missing!
	echo
	exit 1
}

typeset SID_LIST
typeset RMAN_LEVEL

while read line
do
	# skip empty lines
	if [[ $line =~ ^\s*$ ]]; then
		echo empty
		continue
	fi

	# skip comments
	if [[ $line =~ ^# ]]; then
		echo comment
		continue
	fi

	# match characters followed by ':'
	if [[ ! $line =~ ^[[:alnum:]_]+: ]]; then
		echo Format not Recognized: $line
	fi

	# expected config values
	if [[ $line =~ ^RMAN_LEVEL: ]]; then
		echo RMAN_LVL
	elif [[ $line =~ ^SID_LIST: ]]; then
		echo SID_LIST
	elif [[ $line =~ ^BKUP_HOME: ]]; then
		echo BKUP_HOME
	else
		echo "Parameter '$line' not recognized"
	fi

done < $configFile


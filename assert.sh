#!/bin/bash

typeset -r DEBUG=1

debugOut () {
	[[ $DEBUG -eq 1 ]] && {
		echo >&2
		echo "$*" >&2
	} 
}

_testAlpha () {
	typeset valueToTest="$*"

	if [[ $valueToTest =~ ^[[:alpha:][:punct:]\ \	]+$ ]]; then
		debugOut "_testAlpha success for $valueToTest"
		echo 0
	else
		debugOut "_testAlpha failed for $valueToTest"
		echo 1
	fi

}

_testNumber () {
	typeset valueToTest="$*"

	if [[ $valueToTest =~ ^[[:digit:].,]+$ ]]; then
		debugOut "_testNumber success for $valueToTest"
		echo 0
	else
		debugOut "_testNumber failed for $valueToTest"
		echo 1
	fi

}

_testAlnum () {
	typeset valueToTest="$*"

	if [[ $valueToTest =~ ^[[:alnum:][:punct:]\ \ ]+$ ]]; then
		debugOut "_testAlnum success for $valueToTest"
		echo 0
	else
		debugOut "_testAlnum failed for $valueToTest"
		echo 1
	fi

}

_testHex () {
	typeset valueToTest="$*"

	if [[ $valueToTest =~ ^[[:xdigit:]\ ]+$ ]]; then
		debugOut "_testHex success for $valueToTest"
		echo 0
	else
		debugOut "_testHex failed for $valueToTest"
		echo 1
	fi

}


: <<'JKS-DOC'

use assert to verify that a variable contains the expected data type

Valid data types
ALPHA
HEX
NUMBER
ALNUM



JKS-DOC

assert () {
	typeset varName=$1; shift
	typeset varType=$1; shift
	typeset varValue="$*"

	typeset testResult=0;

	debugOut "debug: $varName: $varValue"

	[[ -z $varValue ]] && {
		echo 
		echo "Error!"
		echo "value of variable $varName is empty"
		echo "$varName: $varValue"
		exit 1
	}

	# convert to upper case
	varType=${varType^^}

	debugOut "varType: |$varType|"

	typeset -A assertRE 

	case $varType in
		ALPHA) testResult=$( _testAlpha "$varValue");;
		NUMBER) testResult=$( _testNumber "$varValue");;
		ALNUM) testResult=$( _testAlnum "$varValue");;
		HEX) testResult=$( _testHex "$varValue");;
		*) echo "error in assert - abort!"; exit 99;;
	esac 

	debugOut 'testResult: ' $testResult

	if [ "$testResult" -ne 0 ]; then
		echo
		echo "Error!"
		echo "value of variable $varName is not $varType"
		echo "$varName: $varValue"
		echo 
		exit 2
	fi

}

vName=$1
vType=$2
vVal=$3

assert $vName $vType "$vVal"

echo
echo 'OK!'
echo









#!/bin/bash

# global variables

typeset -r DEBUG=0

typeset -A assertRE
assertRE[ALPHA]="[[:alpha:][:punct:]\ \	]"
assertRE[NUMBER]="[[:digit:].,]"
assertRE[ALNUM]="[[:alnum:][:punct:]\ \ ]"
assertRE[HEX]="[[:xdigit:]\ ]"

typeset -r assertRE

# functions

debugOut () {
	[[ $DEBUG -eq 1 ]] && {
		echo >&2
		echo "$*" >&2
	} 
}

_assert () {
	typeset RE="$1"; shift
	typeset valueToTest="$*"

	debugOut "_assert RE: |$RE|"

	if [[ $valueToTest =~ ^${RE}+$ ]]; then
		debugOut "_assert success for $valueToTest"
		echo 0
	else
		debugOut "_assert failed for $valueToTest"
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


	case $varType in
		ALPHA|NUMBER|ALNUM|HEX) ;;
		*) echo "error in assert - abort!"; exit 99;;
	esac 

	testResult=$( _assert "${assertRE[$varType]}" "$varValue")

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



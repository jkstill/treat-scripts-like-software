#!/bin/bash

# global variables

typeset -r DEBUG=0
#set -v

typeset -A assertRE
assertRE[ALPHA]="[[:alpha:][:punct:]\ \	]"
assertRE[NUMBER]="[[:digit:].,]"
assertRE[ALNUM]="[[:alnum:][:punct:]\ \ ]"
assertRE[HEX]="[[:xdigit:]\ ]"
assertRE[PATH]="[_[:alnum:]\/\.\-]"

typeset -r assertRE

typeset -r assertKeys='+(ALPHA|NUMBER|ALNUM|HEX|PATH)'
shopt -s extglob

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
PATH


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
		# this should be generated from asertRE keys
		#ALPHA|NUMBER|ALNUM|HEX|PATH) ;;
		${assertKeys}) ;;
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

debugOut $assertKeys

assert $vName $vType "$vVal"

echo
echo 'OK!'
echo



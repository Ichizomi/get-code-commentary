#!/bin/bash
# This script saves all javascript comments from 
#an input .js file to and output text file!
# Instructions:
# 1) - place the input .js file on the same folder as this script.
# 2) - run this script via terminal and send the file name.js as first argument.
# 		send name.txt as second argument for output
inputfile=$1
outputfile=$2
echo $inputfile
echo $outputfile
pcregrep -M -o "(/\*([^*]|(\*+[^*/]))*\*+/)|(//.*)|(<!--.*)|(#.*)" ${inputfile} >${outputfile}

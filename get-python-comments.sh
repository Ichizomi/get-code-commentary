#!/bin/bash
# This script saves all python comments from 
#an input .py file to and output text file!
# Instructions:
# 1) - place the input .py file on the same folder as this script.
# 2) - run this script via terminal and send the file name.py as first argument.
# 		send name.txt as second argument for output
inputfile=$1
outputfile=$2
echo $inputfile
echo $outputfile
pcregrep -M -o "(\"\"\"((.|[\r\n])*?)\"\"\")|(#.*)" ${inputfile} >${outputfile}

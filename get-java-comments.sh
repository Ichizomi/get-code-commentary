#!/bin/bash
# This script saves all java comments from 
#an input .java file to and output text file!
# Instructions:
# 1) - place the input .java file on the same folder as this script.
# 2) - run this script via terminal and send the file name.java as an argument.
inputfile=$1
outputfile=$2
echo $inputfile
echo $outputfile
pcregrep -M -o "(/\*([^*]|(\*+[^*/]))*\*+/)|(//.*)" ${inputfile} >${outputfile}
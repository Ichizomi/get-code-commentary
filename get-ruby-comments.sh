#!/bin/bash
# This script saves all ruby comments from 
#an input .rb file to and output text file!
# Instructions:
# 1) - place the input .rb file on the same folder as this script.
# 2) - run this script via terminal and send the file name.rb as first argument.
# 		send name.txt as second argument for output
inputfile=$1
outputfile=$2
echo $inputfile
echo $outputfile
pcregrep -M -o "(=begin[\r\n]((.|[\r\n])*?)=end[\r\n])|(#.*)" ${inputfile} >${outputfile}

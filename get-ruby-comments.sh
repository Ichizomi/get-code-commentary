#!/bin/bash
# This script saves all ruby comments from 
#an input .rb file to and output text file!
# Instructions:
# 1) - place the input .rb file on the same folder as this script.
# 2) - run this script via terminal and send the file name.rb as first argument, send the desired.
# 		output directory. (directory must exist, optional argument).

# Program Variables
# If there is only one argument.
if [ $# -eq 1 ]
	then
		inputfile=$1 # Path + Filename	
fi
# If there are two arguments.
if [ $# -eq 2 ]
	then
		inputfile=$1 # Path + Filename
		outputpath=$2 # Path
fi
truename=$(echo ${inputfile} | grep -o "[^\/]*\.rb") # Grab true file name without path
outputfile="Output.txt" # Discartable Output
outputfile2="Output2.txt" # Discartable Output
outputfile4="Output4.txt" # Discartable Output
character="\`" # Scaping of a special character
# If there is only one argument (single-file).
if [ $# -eq 1 ]
	then
	outputfile3="${truename}_Output.txt" # Final Output File
# If there are two arguments (multi-file).
fi
if [ $# -eq 2 ]
	then
	mkdir -p ${outputpath}
	mkdir -p "${outputpath}/CommentsPerFile"
	outputfile3="${outputpath}/CommentsPerFile/${truename}_Output.txt" # Final Output File
fi

# Convert Unix Line endings
unix2dos -n ${inputfile} "${inputfile}_DOS"
# Get all commentaries and all strings inside file.
pcregrep -M -o "([\"\'\`].*[\"\'\`])|(=begin[\r\n]((.|[\r\n])*?)=end[\r\n])|(#.*)" "${inputfile}_DOS" >${outputfile}
# Replace all CRLF with \r
sed ':a;N;$!ba;s/\r\n/\\r/g' <${outputfile} >${outputfile2}
# Remove all strings from file
sed 's/^".*//g' <${outputfile2} > ${outputfile3}
sed "s/^'.*//g" <${outputfile3} > ${outputfile4}
sed "s/^\`.*//g" <${outputfile4} > ${outputfile2}
# Remove all empty lines from file
sed '/^$/d' <${outputfile2} > ${outputfile3}
# Clean temporary files
rm ${outputfile}
rm ${outputfile2}
rm ${outputfile4}
rm "${inputfile}_DOS"
# If there are two arguments (multi-file). Insert the path + filename in the first line of the archive.
if [ $# -eq 2 ]
	then
	sed -i '1 i\File: '${inputfile}'' ${outputfile3}
fi
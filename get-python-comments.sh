#!/bin/bash
# This script saves all python comments from 
#an input .py file to and output text file!
# Instructions:
# 1) - place the input .py file on the same folder as this script.
# 2) - run this script via terminal and send the file name.py as first argument, send the desired
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
truename=$(echo ${inputfile} | grep -o "[^\/]*\.py") # Grab true file name without path
outputfile="Output.txt" # Discartable Output
outputfile2="Output2.txt" # Discartable Output
outputfile4="Output4.txt" # Discartable Output
character="\`" # Scaping of a special character
character2="\'" # Scaping of another special character
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
# Replaces all small u characters with U+00C6 unicode character
sed -r 's/u/\xC6/g' <"${inputfile}_DOS" > "${outputfile}"
# Get all commentaries and all strings inside file.
pcregrep -M -o "((\x{00C6}|\x{0072}|\w{0055}|\w{0052})\'\'\'(\s{0,2}|.)*\'\'\')|(\"[^\"]+\")|([\'\`].*[\'\`])|(r?\"\"\"((.|[\r\n])*?)\"\"\")|(#.*)" "${outputfile}" >${outputfile2}
# Remove all R or U type ''' """ strings from file.
pcregrep -M -o "((\x{00C6}|\x{0072}|\x{0055}|\x{0052})(\'\'\'|\"\"\")(\s{0,2}|.)*(\'\'\'|\"\"\"))" <${outputfile2} > ${outputfile4}
# Compare file that has all commentaries and strings with one that has only R or U type strings. And remove then
comm --nocheck-order -2 ${outputfile2} ${outputfile4} > ${outputfile}
awk '!/^\t/' <${outputfile} > ${outputfile4}
# Replace all CRLF with \r
sed ':a;N;$!ba;s/\r\n/\\r/g' <${outputfile4} >${outputfile}
# Remove all strings from file
sed 's/^u.*//g' <${outputfile} > ${outputfile4}
sed 's/^""".*"""/ &/g' <${outputfile4} > ${outputfile} # Add a space before the Python multi-line comments. So its safe to remove strings.
sed 's/^"[^"]*"//g' <${outputfile} > ${outputfile4} # Remove strings
sed 's/^\s//g' <${outputfile4} > ${outputfile} # remove temporary whitespace
sed "s/^'.*//g" <${outputfile} > ${outputfile4}
sed "s/^\`.*//g" <${outputfile4} > ${outputfile}
# Replaces back all U+00C6 unicode character with small u characters 
sed -r 's/\xC6/u/g' <${outputfile} > ${outputfile4}
# Remove all lines that start with a CSS hexcode colors
awk '!/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3});.*/' <${outputfile4} > ${outputfile}
# Remove all empty lines from file
sed '/^$/d' <${outputfile} > ${outputfile3}
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
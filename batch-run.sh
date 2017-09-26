#!/bin/bash
# This script executes one my other scripts on multiples files
# Instructions:
# Send the script name as the first argument, the directory that you wish to inspect as second argument, the extension of the files as
#third argument.
# For Example: sh batch-run.sh get-java-comments.sh RoboCoP-master .java
script=$1
directoryname=$2
extension=$3
outputfolder="${directoryname}_Output"
# Run the script for all .extension files in the specified directory
shopt -s globstar
for f in ${directoryname}/**/*${extension};
do 
	sh "${script}" "${f}" "${outputfolder}"
done
# Concatenate all the files in a single one.
finaloutput="${outputfolder}/AllComments.txt"
cat "${directoryname}_Output/CommentsPerFile/"*.txt > ${finaloutput}
# Delete dump directory
#rm -r ${outputfolder}/CommentsPerFile
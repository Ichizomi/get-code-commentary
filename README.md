# get-code-commentary
Retrieve all commentaries from code files in one of the following languages: Java, Javascript, Python, PHP e Ruby

Status: [Work in Progress - 08/17/2017]

This repository will contain shell scripts code that can retrieve commentaries from source files from one of the following programming 
languages:
- Java
- JavaScript
- Python
- PHP
- Ruby

They all use the command pcregrep and regular expressions to retrieve the commentaries. 
Note: You might have to install the pcregrep package to get it working, since I use Windows I installed it fromthe CygWin installer.
This project is being created to aid in a scientific research at UFMS (Universidade Federal de Mato Grosso do Sul).

You can run those codes in Unix distributions (not confirmed), but I tested then in Windows (by having CygWin installed and 
running the command "sh file.sh" in the command-line.)

Note: The regular expressions contained within these codes are not perfect, right now they may retrive some false-positives such
as URLs inside strings. 

Project Scripts:
- Java
  - get-java-comments.sh
    Description: this script takes one java file and retrieve all commentaries in an output text file.
    It requires two arguments, the first is the input file name, and the second the output file name.
    Example: sh get-java-comments.sh FileName.java output1.txt
    Note that all files must be within the same directory of the .sh file

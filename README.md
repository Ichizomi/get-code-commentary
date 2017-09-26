# get-code-commentary
Retrieve all commentaries from code files in one of the following languages: Java, Javascript, Python, PHP e Ruby

Status: [Release 01 / Testing - 09/26/2017]

This repository contain shell scripts that can retrieve commentaries from source files from one of the following programming 
languages:
- Java
- JavaScript
- PHP
- Python
- Ruby

They all use the command pcregrep and regular expressions to retrieve the commentaries. 
Note: You might have to install the pcregrep package to get it working. I use Windows so I installed it from the CygWin installer.

This project is being created to aid in a scientific research at UFMS (Universidade Federal de Mato Grosso do Sul). You can contact me at rksgrijo@gmail.com

How-To Use Instructions:
  You can run those codes in Unix distributions (not confirmed yet), but I tested then in Windows! (by having CygWin installed and 
running the command "sh file.sh" in the command-line)
  
  - To run in a single file, place the respective programming language .sh in the same folder of the target file and run on the command line the following: sh get-code-comments.sh target.java
    For instance: sh get-java-comments.sh myFile.java
    A resulting myFile_Output.txt will be created containing all the comments.
 - To run on multiple files, place the respective programming language .sh and the batch-run.sh in the same folder of the target directory that contain all desired .extension files (It works even if the files are inside different subfolders. As in git-hub's masters directories). Run the following on the command line: sh batch-run.sh get-code-comments.sh foldername .extension
    For instance: sh batch-run.sh get-java-comments.sh myDirectory .java
    After a while, a resulting myDirectory_Output will be created containing a CommentsPerFile Folder and a AllComments.txt

How It Works:
  When looking for comments in a programming language using a regular expression, some false-positives might be collected accidentaly.
  For example, in Java the possible commentaries types are:
    - // (Single-Line)
    - /* (Multi-line)
    - /** (JavaDoc)
  If the code has a string that contains one of those characters like String s = "https://github.com/"
  This would be collected by a regular expresion although it's not a commentary.
  To fix this problem, my regular expressions were modified to no only get comments, but also all the strings! Afterwards they are individually removed from the output, resulting in only the comments themselfs.
  If you are interested only in the regular expressions for getting only the comments here they are:
  Java ```(\/\*([^*]|(\*+[^*/]))*\*+\/)|(\/\/.*)```
  JavaScript ```(/\*([^*]|(\*+[^*/]))*\*+/)|(//.*)|(<!--.*)```
  PHP ```(\*+[^*/]))*\*+/)|(//.*)|(<!--.*)|(#.*)```
  Python ```(\"\"\"((.|[\r\n])*?)\"\"\")|(#.*)```
  Ruby ```(=begin[\r\n]((.|[\r\n])*?)=end[\r\n])|(#.*)```
  If you want to fix the false-positives problems, simple use my codes or study how they work.
  
Additional Notes:
  This code is not optimized at all, I'm only a beginner at shell scripts, so I might have used unnecessary operations. If you can optimize this code, by any means feel free to contribute or contact me. It may take long times to run on large directories with multiple .extension files.
  

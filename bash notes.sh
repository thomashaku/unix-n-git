1. Navigation
"command line": "a text interface for the computer's operating system"
"$": "shell prompt"
"ls": a "command" = "dir" in windows CMD
folder = "directory"
files & directories are organised into "filesystem": "organisze a computer's files and directories into a tree structure"
“pwd": "print working directory"
"cd <directory name>": "change directory"
	without argument, it will go to the "root directory"
	the final "/" is optional
	can take a series of folders: "cd 2015/jan/"
	"cd .." means move up one directory
	can combine the above 2: "cd ../feb", "cd ../.."
	can tap "tab" to avoid typing the full path
"mkdir <directory name>": "make directory"
	can use space to create >1 directories in one line
"touch <file name>": "create a file with a given name"
	can combine with directory name: "touch bmx/tricks.txt"

"Bash": "Bourne-Again SHell"
echo "Hello Command Line" >> hello.txt
	create a file called "hello.txt", and append those texts into  it
"cat <file name>": print the contents



2. Manipulation
"ls <"options">: 
	"-a": also list hidden files and directories which start with a dot "."
	"-l": in long format. show 7 attributes
		access right: w: write, x: execute, r: read, 3 groups: TO BE ADDEDE
		number of hard links: the number of child directories and files + parent & current directory links (".." and "." respectively)
		owner's username
		name of the group that owns the file
		file/directory size: in bytes
		date & time last modified
		file/directory name
	"-t": ordered by time last modified
	can combine all: "ls -alt"
"cp <source> <target>": "copy"
	source can be multiple files
	target's file name can be specified -> copy file to another file (newly created)
	target can be a directory -> copy file to directory
	use "*", a "wildcard" character, to copy all files (excluding folders);
		or vaguely match the name: "m*.txt": all files start with "m" and ends with ".txt"
	if target file already exists, overwrite it with source file (i.e. copy contents)
"mv <source> <target>": "move"
	source can be multiple files into target folder
	if target is a file, you are doing rename operation
"rm": remove
	"rm <name>": remove a file
	"rm -r <name>": 
		"-r": recursive, remove a directory and all its child files and directories
		if you want to preserve the parent folder: "rm <currentFolderName>/*"

3. Redirection
"echo <DoublyQuotedString>"
	take standard input and echoes it back to the terminal as standard output
	stdin, stdout, stderr (error message ouputted by a failed process)
echo "hello" > hello.txt 
	">" command redirect the standard output to a file.
cat fileA.txt > fileB.txt: A's stdout is directed to B, overwrite all
cat fileA.txt >> fileB.txt: A's stdout is directed to B, append below
	"cat": cut-paste vs "cp": copy-paste
cat < hello.txt: takes stdin from the file and input it into the program on the left
	redirect stdin to a command
	"<" is redundant in this case. DO SOME RESEARCH ON THIS
"|": pipe, take stdout of the command on the left, and pipes it as stdin to the right
	"cat hello.txt | wc"
		cat stdout of hello.txt as stdin to command "wc": stands for "word count"
	"cat hello.txt | wc | cat > hello2.txt"
		"wc" result (stdout) is redirected as stdin to "cat" (which finally is written in hello2.txt)
"sort <file>":
	output sorted file content (line by line)
	"cat hello.txt | sort > sorted-hello.txt"
">": storage vs "|": used as input
"uniq <fileName>":
	output unique lines (remove duplicates that are only adjacent)
	"sort hello.txt | uniq > unique-sorted-hello.txt"
"grep (<-i>) <pattern> <file>":
	"global regular expression print"
	print lines containing the pattern, optional "-i" to make case insensitive
"grep <-R> or <-Rl> <pattern> <directory>"
	search all files in the directory whose contents contains such pattern
	"-R": recursive, print "<fullPath>:<line>"
	"-Rl": print only "<fullPath>"
	pattern can be regex -> advanced
"sed": stream editor
	"sed '<s/searchStr/replaceStr/(g)>' <file>"
		"s": substitution, always
		"g": global, without which it will only replace the first result found in each line


4. Environment
preferences and settings of the current user
"nano <file>"
	nano: a command line text editor
	in-program commands/hotkeys, "^" stands for the "Ctrl" key
"clear"
"nano ~/.bash_profile"
	"~/.bash_profile": name of the file used to store environment settings, often called "bash profile"
		"~" represents the user home directory
		"." indicates a hidden file
after you typed echo "Welcome!" and saved it in nano and exited...
"source ~/.bash_profile"
	activates the changes in the bash profile for the current session
	command aliases, NOT EXPORT:
		alias pd="pwd"
		alias hy="history"
set "environment vairiables": export VARIABLE="Value"
	used across commands and programs & hold information about the environment
	in the bash profile: export USER="Thomas" (uppercase with underscore is thes convention)
		all child sessions will inherit this
	exit and use "source" to activate
	"echo $USER" -> Thomas
		"$" always used to return the value of a variable
	export PS1=">> "
		PS1: command prompt variable
	echo $HOME -> path of the home directory
	echo $PATH -> stores a list of drectories, separated by a colon
		each directory contains scripts for the command line to exeecute
		e.g. pwd, ls are stored in /bin
"env": environment
	returns a list of the environment variables for the current user
	e.g. PATH, PWD, PS1, HOME ...
"less <file> (-N)"
	similar to "cat", but handles large files better
	"-N" also shows line numbers


5. Bash Scripting - a bit challenging. Need more learning resource
housekeeping
	first line of the script file: "#!/bin/bash"
	place commonly used scripts in "~/bin/" directory
	add execute permission to your script
		run "chmod +x <script name>" in terminal
	finally run your script by "./<script name>.sh"
variables
	<varName>="<value>", no space
		no "" for integer
	echo $<varName>
conditionals
	syntax
	"
		if [ <condition> ]
		then
			<statement>
		else
			<statement>
		fi
	"
	must have space in []
	place <statement> after "fi"
	comparison operators
		-eq: equal, -ne: not equal,
		-le: less than or equal, -lt: less than,
		-ge: greater than or equal, -gt: greater than
		-z: is null

		for strings: == and !=
	put variables in quotes to avoid space/null errors:
		if ["$foo" == "$bar"]
loops
	for
	"
		for word in $paragraph
		do
			echo $word
		done
	"
	no "$" before the first "word" because "$" is for accessings
	while
	"
		while [ $index -lt 5 ]
		do
			echo $index
			index=$((index + 1))
		done
	"
	until
	"
		until [ $index -eq 5 ]
		do
			echo $index
			index=$((index + 1))
		done
	"

input
	read <variable name>
		echo "Guess a number"
		read number
		echo "You guessed $number"
	command line argument
		accessed using "$1", "$2" ...
			for color in "$@"
			do
				echo $color
			done
		"@" accept an indefinite number of input arguments
		finally in terminal: "<script name> red blue yellow"
	access external files
		files=/some/directory/*
		for file in $files
		do
			echo $file
		done
alias - in "~/.bashrc" or "~/.bash_profile"
	alias <command name>='./<script name>.sh'
	alias saycolors='./saycolors.sh "green"'
		for taking indefinite number of arguments, but
		always include "green" as the first argument
		if one argument only, use alias <>="./<> arg" instead
comment: "#" symbol

## 📃 Definition

- **Terminal**: A program or environment that allows users to interface with the computer's shell. Often referred to as a terminal emulator, it replicates the functions of ancient physical terminals in modern GUI environments.
- **Shell**: A software interface that allows users to interact with the operating system by executing commands. It can operate in a command-line interface (CLI) or a graphical user interface (GUI) mode.
- **Bash**: An acronym for "Bourne Again Shell", Bash is a Unix shell and command language. It's an enhanced version of the Bourne Shell (`sh`) and provides advanced features such as command-line history, job control, and command-line editing.

## ✅ Terms

- **Script**: A set of commands written in a file which can be executed sequentially.

- **Interpreter**: A program that reads and executes code. For shell scripts, the shell acts as the interpreter.

- Debug:

```Bash
set -x
for i in {1..5}
do
	echo ${i}
done
set +x
```

- IO Streams:

```
#Inputs
/dev/stdin (0)                       #Keyboard
/dev/zero                            #Zeros Input
/dev/random                          #Random Input
/dev/urandom                         #Random Input
#Outputs
/dev/stdout (1)                      #Output (Screen)
/dev/stderr (2)                      #Error (Screen)
/dev/null                            #Garbage
/dev/full                            #Fill Size For Testing
```

- Composite Commands:

```Bash
#Sequential Commands
<First_command>;<Second_command>;<Third_command>
#Conditional Commands
<First_command> || <Second_command>      #first should fail to execute Second
<First_command> && <Second_command>      #first should pass to execute Second
#Command Loops
for file in *.txt
do
echo ${file} >> ${file}
done 
#Output Redirection
<command> <stream_number> > <file>          #Redirect Output With Overwrite
<command> <stream_number> >> <file>         #Redirect Output With Append
<command> > <file> <stream_1> > &<stream_2> #Redirect stream_1 to stream_2
<command> &> <file>                         #Redirect All Streams
#Input Redirection
<command> < <file>                   #Get File Conent and Pass it to Command
#Pipes
#Command Argument Expansion
#Command Argument Quoting
```

- Mathematical Expressions:

```Bash
x=8
y=9
#Expression
z= expr ${x} + ${y}
###################################################
#Let
let z=${x}+${y}
echo $z
###################################################
#Rounded Prackets
z=$(($x+$y))
echo $z
###################################################
#Arthimatic
if [ ${x} -ne 0 -a ${y} -ne 0 ];
then
     echo "True"
fi
#And Concept
if [ ${x} -ne 0 ] && [ ${y} -ne 0 ];
then
     echo "True"
fi
#Unlimited And
if [[ ${x} -ne 0 && ${y} -ne 0 ]];
then
echo "True"
fi
#Like c
if (( ${x}!=00 && ${y}!=00 ));
then
echo "True"
fi
```

- **Shebang (`#!`)**: A character sequence at the very top of a script that specifies the interpreter for the script.

```SHELL
#!/bin/bash
```

- **Comments**:

```BASH
#Single Line Comment
<<`Delimiter`
Multi Line Comment
'Delimiter'
```

- **Wildcards**: apply on names and directories

```BASH
#(*) All
ls *.log
#(?) One Char
ls *.lo?
#([<char>]) Some Chars
ls [abc]*.log
#([!<char>]) Not Some Chars
ls [!abc]*.log
#([<Start>-<Stop>]) Range
ls [a-bx-z]*.log
#([[:<chass>:]]) Class -> alpha - alnum - digit - lower - upper
ls [[:alnum:]]*.log
#(\) Escape Sequencd
ls a\ bc.log
# Lists all files not starting with 'a'
ls [^a]*      
# Lists a.txt, b.txt, and c.txt
ls {a,b,c}.txt 
```

- **Variables**: Named storage locations used to hold values which can be referenced and manipulated within a script.

```BASH
Variable="Hello"
echo ${Variable}
```

- **Environment Variables**: Variables that can affect the way running processes will behave on a computer. Examples: `PATH`, `HOME`, `USER`.

```SHELL
echo $PATH
echo $HOME
echo $USER
```

- **Positional Parameters**: Variables (`$0`, `$1`, `$2`, ... `$n`) that contain the arguments provided to the script upon execution.

```SHELL
./Script.sh A B
#Process ID
echo $$
#File Name Name -> ./Script.sh
echo $0
#First Argument -> A
echo $1
#Seond Argument -> B
echo $2
#Number Of Arguments -> 2
echo $#
#All The List as list -> A B
echo $@
#All The List as string -> A B 
echo $*
#Return Last Operation
echo $?
```

- **Exit Status**: A numeric value returned by every command to indicate its success (`0`) or failure (non-zero).

```SHELL
echo $?
```

- **Command Substitution**: A method of using the output of one command as an argument for another.

```BASH
#More Popular
`$(command)`
#Old One
`command`
```

- **Loops**: Constructs that execute a set of commands repeatedly. Common loops in shell scripting are `for`, `while`, and `until`.

```SHELL
#untill Loop
Counter=0
until [ $count -ge 5 ]
do
    echo "Count is: $Counter"
    Counter=$((Counter + 1))
done
###################################################
#For Loop
Counter=0
for File in $(ls);
do
     echo Files = $File
     ((Counter++))
done
#Loop In Data
for i in 1 2 3 4 5
do
	echo ${i}
done
#loop In Range
for i in {1..10}
do
	echo ${i}
done
#Loop On Words
name="Hello World"
for i in ${name}
do
	echo ${i}
done
###################################################
# While Loop
echo $Counter
while [ $Counter -ne 0 ];
do
     echo Counter = $Counter
     ((Counter--))
done
```

- **Conditional Execution**: Allows different sets of commands to be executed based on the truthiness of a condition. The common constructs are `if`, `elif`, and `case`.

```SHELL
#Test
test "Khaled"="Khaled" && echo "True" || echo "False"
[ "Khaled" = "Khaled" ] && echo "True" || echo "False"
###################################################
#If Condition
read -p "Enter a number: " num 
if [ "$num" -gt 10 ];
then
echo "Number is greater than 10."
elif [ "$num" -lt 10 ];
then 
echo "Number is less than 10."
else
echo "Number is 10."
fi
###################################################
#Case Condition
read -p "Enter a color (red/blue/green): " color
case $color in
	red) echo "You chose red!" ;;
	blue) echo "You chose blue!" ;;
	green) echo "You chose green!" ;;
	*) echo "Not a valid choice!" ;;
esac 
#Or In Case Condition
read -p "Enter Text : " Text
case ${Text} in
"Yes"|"yes") echo True ;;
"No") echo False ;;
*) echo None ;;
esac
```

- **Functions**: Named sequences of commands that can be reused within a script.

```SHELL
# Function definition
Say_Hello()
{
    echo "Hello $1"
    return 0
}
# Call function
Say_Hello "Alice"
Say_Hello "Bob"
###################################################
#Tricks
tst1() {
     echo Hello World !
}
function tst2
{
     echo Hello World !
}
function tst3{
{
     echo Hello World !
}
tst3{
tst2
tst1
#Arguments
tst() {
     echo Hello World ! "${0}" "${1}"
}
tst Hello #-> Hello World ! <Program Paht> Hello
#Return
tst()
{
     return $(( ${1} + ${2} ))
}
tst 10 20
echo Result = ${?}
###################################################
#Source Bash Script (Export Variables To Current Bash)
./Script.sh                  #Run In External Terminal
#!/bin/bash
export x=11
. Script.sh
#Or
source ./Script.sh
```

- **Arrays**: Data structures that can hold multiple values, referenced by an index or key.

```Shell
#Declare
declare -a Array=("File_1" "File_2")
#First Element
echo ${Array[0]}
#Array Size
echo ${#Array[@]}
#Overwrite
Array[0]="Ahmed"
#Remove Element
unset Array[0]
#Subistitute
Array_1=(1 2 3 4 5 6)
Array_2=(${Array_1[@]:1:5})
echo ${Array_2[@]}                 #Out -> 2 3 4 5 6
#Loop
Array=('File_1' 'File_2')
for File in ${Array[@]};
do
     echo "Array : $File";
done
#Loop By Index
Array=('File_1' 'File_2')
for File in ${!Array[@]};
do
     echo "Array : ${Array[File]}";
done
```

- **Select & Modifiers**: 

```BASH
#Select Option
select Option in Option_1 Option_2 Option_3
do
echo ${Option}
done
#Select Option
PS3="Select an option (enter the number): "  # Custom prompt message
select Option in Option_1 Option_2 Option_3
do
     case ${Option} in
	     Option_1) echo "Hello (1)";;
	     Option_2) echo "Hello (2)";;
	     Option_3) echo "Hello (3)";;
	     *) break
     esac
done
#Local Variable
x=10
Function()
{
     local x=11
     echo ${x}
}
Function
echo ${x}
#Read Only
x=10
readonly x            #Or -> readonly x=10
x=11                  #Error
#Shift Input Arguments
echo "Before shifting: \$1 = $1, \$2 = $2, \$3 = $3"
shift 2
echo "After shifting: \$1 = $1, \$2 = $2, \$3 = $3"
```

- **Background Process**: A process that runs in the background without interacting with the user. Started by appending `&` to commands.

```SHELL
top &
```

- **Jobs**: Represent running commands and pipelines

- **Alias**: A custom shortcut to reference a command.

- **Files Operations

```Bash
#Cat Command
Data=$(cat File.txt)
echo ${Data}
#Input Command
Data=$(<File.txt)
echo ${Data}
#Read Command
while read Line
do
     echo ${Line}
done < File.txt
#Output To File
echo -n "Todays Date -> " > Date.txt
date >> Date.txt
```

- **Arithmetic Operations**:

```Bash
a=10
b=20
echo $((a + b))  # Addition
echo $((a - b))  # Subtraction
echo $((a * b))  # Multiplication
echo $((a / b))  # Division
```

- **String Operations**:

```Bash
str1="Hello World"
str2="Hello World2"
echo ${#str1}                                 # String length -> 11
echo ${str1:3:4}                              # Substring -> lo W
if [ ${str1} = ${str2} ]                      # Compare String
if [ ${str1} \< ${str2} ]                     # Compare String
echo Word Counts = `echo "${Text}" | wc -c`   # Count Chars 
#Split String Using IFS
Range="192.168.0.0"
IFS='.'
read -a Array <<< "$Range"
echo ${Array[3]}
#Sliceig
Result="100%"
Result=${Result::-1}
echo Battary Life : $Result
#Trim
Result="100%"
echo ${Result%?}
```

- **File Operations**:

```Bash
if [ -e "filename" ]; then
   echo "File exists"
fi
```

- **Comparison Operations**:

```Bash
if [ $a -eq $b ]; then
   echo "a is equal to b"
fi
```

- **Logical Operations**:

```Bash
if [[ $a -lt 20 && $b -gt 10 ]]; then
   echo "True"
fi
```

 - **Exit Operations**:
 
```Bash
exit 1
```

 - **Case Converting**:
 
```Bash
#Converts the value of `var1` to lowercase.
${var1,,}
#Converts the value of `var1` to uppercase.
${var1^^}
```

## 📂 Files Of Interactions

- **Configuration Files**: `/etc/`, `~/.bashrc`, `~/.bash_profile` -> Store configuration settings that determine how the system or software behaves.

- **Log Files**: `/var/log/` -> Store output logs from various programs and scripts for debugging or monitoring purposes.
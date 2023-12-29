## Make: An Overview

**Definition:** Make is a scripting tool used for building executables based on specified commands. It parses an input file called a `Makefile` to define rules that it will execute.
**Types of Make:**
- GNU Make
- Borland Make

## Why Use Make?

1. **Organize Compilation Process:**
    - Structured approach to compiling code.
2. **Run Tools and Scripts:**
    - Facilitates the execution of various tools and scripts.
3. **Automation:**
    - Automates the build process, reducing manual intervention.
4. **Control Over Outputs:**
    - Ensures full control over outputs and their timing.

## Makefile Naming Convention

- It is not mandatory for the Makefile to be named "Makefile."
- While running, specify the filename using `make -f <filename>`.

## Make Syntax

```makefile
# 1) Setting Rule
all : <prerequisites>
	<recipe>
#####################################################
# 2) Variable & Variable Substitution
<name> = "Test.c"
<name> := "Test.c"
<name> += "Test.c"
all :
	echo $(<name>)
#####################################################
3) Disaple Echo
all : 
	@echo "Hello World !"
#####################################################
4) Access Environment Variables & Shell Commands
all : 
	echo $(PATH)
#####################################################
5) Access External Script
all : 
	@bash <filename>.sh
#####################################################
6) Functions
all :
	$(call <function_name>,<args>)
define <function_name>
	@echo "Function Name $0"
	@echo "Function Argument $1"
	@echo "Target Rule Name $@"
endef
#####################################################
7) Built IN Functions
all :
	echo $(subst .c,.cpp, main.c file.c)      #Replace *.c -> *.cpp
	echo $(sort file2.c file1.c)     #Rearrage
	echo $(word 2, file2.c file1.c)     #Select Second Word
	echo $(word 1,2, file2.c file1.c)     #Select Second And First Word
	echo $(firstword file2.c file1.c)     #Select First Word
	echo $(lastword file2.c file1.c)     #Select Last Word
#####################################################
8) Loops
List = One Two Three
with_for :
    @for i in $(List); \
    do                \
        echo "$$i";   \
    done
with_foreach :
	echo $(foreach Word,$(List),"Word = $(Word)")
#####################################################
9) If Conditions
# ifeq (<cond_1>,<cond_2>)
# ifneq "<cond_1>" '<cond_2>'
# ifdef <variable_name>
all:
ifeq '$(File)' 'Test.c'
	@echo "True"
endif
#####################################################
# Avoid conflict between filename and target
10) Phony
.PHONY: clean
clean:
	@echo "No Conflict When File Exist"
#####################################################
#Include Configuration File To Make
11) Include
include <filename>
all:
	echo $(Message)
#####################################################
12) Automatic Variables
all : 
	@echo "Target Name : $@"
	@echo "First Prerequisite : $<"
	@echo "All Prerequisites : $^"
#####################################################
```  

## Make Build In Rules

```BASH
# Print Make INternal Database
make -p
# Do not use internal database 
make <rule> -r
```

## Common Usage

```BASH
C_Files := Main.c File.c
O_Files := $(C_Files:.c=.o)
####################################################
build: main.o test .o
	$(CC) $^ -o runprogram
####################################################
#Change Make Default Directory
make -C <path>
####################################################
# (@)                   -hide command
# (%.o)                 -all object files
# $(CC)                 -replace variable
# ($<)                  -One Dependency at time
# ($@)                  -One Output at time
# ($(wildcard *.c))     -all fiiles .c
# $(CC)                 -replace variable
####################################################
####################################################
```
# References:

1- [GNU `make` Manual](https://www.gnu.org/software/make/manual/html_node/index.html)
2- [GNU `make`](https://www.gnu.org/software/make/manual/html_node/index.html)
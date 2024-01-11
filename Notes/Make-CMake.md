# Make
## An Overview

**Definition:** Make is a scripting tool used for building executables based on specified commands. It parses an input file called a `Makefile` to define rules that it will execute.
**Types of Make:**
- GNU Make
- Borland Make

## Why Use Make

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

## `Makefile` Syntax

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

``` SHELL
# Print Make INternal Database
make -p
# Do not use internal database 
make <rule> -r
```

## Common Usage

```SHELL
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




---
# CMake
## An Overview

**Definition:** CMake is a cross-platform build-system generator. It uses a scripting language within a `CMakeLists.txt` file to define rules for building executables and libraries.
## Why Use Make

1. **Organize Compilation Process:**
    - Provides a structured approach to compiling code.
2. **Run Tools and Scripts:**
    - Facilitates the execution of various tools and scripts during the build process.
3. **Automation:**
    - Automates the build process, reducing manual intervention.
4. **Control Over Outputs:**
    - Ensures full control over outputs and their timing.
## CMakeLists.txt Naming Convention

- It is not mandatory for the CMakeLists.txt file to be named a specific way.
- While running, specify the filename using `cmake -f <filename>` or by default using `CMakeLists.txt`.
## `CMakeLists.txt` Syntax

```cpp
#Set Version
cmake_minimum_required(VERSION 3.22)
#Set Project Name
PROJECT(Test_C++)
#Select Building Files And Executable Name
add_executable(Main Company.cpp Main.cpp)
#Add Include Directory
target_include_directories(Main PUBLIC Files/)
#Pass Include To VS-CODE
include_directories(/Files)
#Set Variable
set(SRC_FILES 
    Files/Company.cpp 
    Application/Main.cpp)
#Print Message (FATAL_ERROR-WARNING-STATUS)
message(FATAL_ERROR "Files To Be Compiled : ${SRC_FILES}")
#Make Condition
if(EXISTS ${CMAKE_SOURCE_DIR}/Main.cpp)
	message("Compiling Main")
else()
	message("Compiling Main")
endif()
#Inheret Other CMAKE
add_subdirectory(${CMAKE_SOURCE_DIR}/Libraries)
#Link Library
target_link_libraries(Main PUBLIC MathLibrary)
# Create a library add SHARED to make it dynamic
add_library(MathLibrary ${SOURCES})
#Add Configuration File
configure_file(Default_Config.in Default_Config.h)
#For Loop
foreach(Character IN ITEMS Ahmed Omar Mohamed Adel)
	message(STATUS ${Character})
endforeach()
#While Loop
set(Counter 10)
while(Counter)
    message(STATUS ${Counter})
    math(EXPR Counter "${Counter}-1")
endwhile()
#Function
function(Print_Hello Count)
while(Count)
    message(STATUS "Hello")
    math(EXPR Count "${Count}-1")
endwhile()
endfunction()
Print_Hello(3)
#Save File In Cash
option(Name_1 "Comment_1" TRUE)
set(Name_2 TRUE CACHE BOOL "Comment_2")
#Pass Defenition To Compiler cout<<myname
target_compile_definitions(Main PUBLIC "myname=\"Khaled\"")
#Pass Option To Compiler
target_compile_options(Main PUBLIC -O0 -g)
#Install Application
install(
    FILES "${PROJECT_BINARY_DIR}/${Application_Name}"
    DESTINATION "${PROJECT_BINARY_DIR}/Executable/${Application_Name}"
)
#File Manipulation (READ-STRINGS-GLOB_RECURSE)
file(READ "Application/Main.cpp" Main_Content)
message(${Main_Content})
#String
set(text "int main()")
string(REGEX REPLACE "int" "void" output ${text})
message(${output})
#Execute Process
execute_process(COMMAND "ls")
#Add Coustom Target
add_custom_target(flash ALL
    DEPENDS ${Application_Name}
    COMMAND echo "Im Flasing On Target"
)
#Link Library Directory
link_directories("/user/lib/")
#Add List
list(APPENO SRCFILE main.cpp)
```
## Common Usage

```BASH
#Commands In CMake Case insinsitive 
message("Hello")
MESSAGE("Hello")
#Supported IDEs
cmake -G
#Show All Variables 
cmake --help-variable-list
${CMAKE_SOURCE_DIR}#Main Cmake Source Directory
${CMAKE_CURRENT_SOURCE_DIR}#Current Includded Cmake Source Directory
${CMAKE_BINARY_DIR}#Main Cmake Build Directory
${CMAKE_CURRENT_BINARY_DIR}#Current Includded Cmake Build Directory
${CMAKE_GENERARTOR}#Target Makefile Application
${CMAKE_SYSTEM_NAME}#Set To Genaric For Cross Compile
${CMAKE_CXX_COMPILER}#Set Default CPP Compiler Used
${CMAKE_C_COMPILER}#Set Default C Compiler Used
${CMAKE_OBJCOPY_COMPILER}#Set Default Objcopy Compiler Used
${CMAKE_CXX_FLAGS}#Pass Flags CPP To Compiler
#Set Important Variables
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
#Manipulate With ENV Variables
Message(STATUS "PATH=$ENV{PATH}")
#Set Value While Running 
cmake -DMy_Value=10
Message(STATUS "Value=${My_Value}")
#Configuration File Syntax
define APPLICATION_AUTHOR "KHALED_ELSAYED"
define APPLICATION_YEAR "${YEAR}"
define VERSION_MJOR @TestCPP_VERSION_MAJOR@
define VERSION_MINOR @TestCPP_VERSION_MINOR@
#If Condition
if(<constant>)#OFF-0-FASLE N NOTFOUND IGNORE
if(<relation>)#AND OR MATCHES LESS GREATER EQUAL
if(TARGET )
#Function
function(Print_Hello Count)
while(Count)
    message(STATUS "Hello")
    message(STATUS "${ARGN}")#EXTRA ARGUMENTS
    message(STATUS "${ARGC}")#ARGUMENTS COUNT
    math(EXPR Count "${Count}-1")
endwhile()
endfunction()
Print_Hello(3)
#Search For CPP Files
file(GLOB_RECURSE SRC_FILES "./Source/*.cpp")
file(GLOB_RECURSE SRC_FILES RELATIVE ${CMAKE_SOURCE_DIR} "./Source/*.cpp")
```
# References:

1- [GNU `make` Manual](https://www.gnu.org/software/make/manual/html_node/index.html)
2- [GNU `cmake` Manual](https://cmake.org/cmake/help/latest/index.html)
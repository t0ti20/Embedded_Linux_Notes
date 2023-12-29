A toolchain is a set of utilities designed to take source files and compile them to produce an executable file, intended to run on a specific architecture. You can acquire a toolchain in two ways:
- Directly download it from sites like Raspberry Pi.
- Customize it using tools like `crosstool-ng`.
## Crosstool-ng
This tool, when provided with specific commands and configurations, fetches repositories and combines them to create a toolchain for your host machine. This allows your host machine to compile source files that will run on your target machine.
The most critical configurations for this tool include:
- Compiler
- C library
- Debug tools
- Linux version (both target and host)
### Installation
First, install the tool's prerequisites:
```SHELL
sudo apt-get install autoconf automake bison bzip2 cmake 
sudo apt-get install flex g++ gawk gcc gettext git gperf help2man 
sudo apt-get install libncurses5-dev libstdc++6 libtool libtool-bin make
sudo apt-get install patch python3-dev rsync texinfo unzip wget xz-utils
```
Then, install `crosstool-ng`:
```Bash
git clone https://github.com/crosstool-ng/crosstool-ng.git
cd crosstool-ng
./bootstrap
./configure --prefix=${PWD}
make
make install
```
### Usage
To use `crosstool-ng`:
```Shell
#Clean Last Build Configuration
bin/ct-ng distclean
#List All Supportex Targets For This Tool
bin/ct-ng list-samples
#Show Default Configuration
bin/ct-ng show-<sample>
#Generate Auto Configuration For THis Target Supported
bin/ct-ng <sample>
#Edit Generated Configuration File
bin/ct-ng menuconfig
#Build Your Targer
bin/ct-ng build
#Output Auto Path: ~/x-tools
```

To understands what inside generated files:
```
./aarch64-rpi4-linux-gnu/
├── aarch64-rpi4-linux-gnu    /*Target Compiler Binary Files*/
└── sysroot                   /*Root File System*/
    ├── etc                   
    ├── lib           
    ├── lib64 -> lib   
    ├── sbin           
    ├── usr                 
    └── var                   
├── bin                       /*Host Compiler Binary Files*/
├── etc                       /*Host Compiler Nedded Files*/
├── include                   /*Host Compiler Nedded Files*/
├── lib                       /*Host Compiler Nedded Files*/
└── share                     /*Host Compiler Nedded Files*/

```

Check For Tool-Chain Version:
```BASH
#find the version
gcc.exe --version
#how it was configured
gcc.exe -v
```

Check  Default Library Directory:
```BASH
aarch64-rpi4-linux-gnu-gcc -print-sysroot
```

## Important tools in the toolchain
- addr2line: Converts program addresses into filenames and numbers by reading the debug symbol tables in an executable file. It is very useful when decoding addresses printed out in a system crash report.
• ar: The archive utility is used to create static libraries.
• as: This is the GNU assembler.
• c++ filt: This is used to demangle C++ and Java symbols.
• cpp: This is the C preprocessor and is used to expand # define, # include, and other similar directives. You seldom need to use this by itself.
• elfedit: This is used to update the ELF header of the ELF files.
• g++: This is the GNU C++ frontend, which assumes that source files contain C++ code.
• gcc: This is the GNU C frontend, which assumes that source files contain C code.
• gcov: This is a code coverage tool.
• gdb: This is the GNU debugger.
• gprof: This is a program profiling tool.
• ld: This is the GNU linker.
• nm: This lists symbols from object files.
• objcopy: This is used to copy and translate object files.
• objdump: This is used to display information from object files.
• ranlib: This creates or modifies an index in a static library, making the linking stage faster.
• readelf: This displays information about files in ELF object format.
• size: This lists section sizes and the total size.
• strings: This displays strings of printable characters in files.
• strip: This is used to strip an object file of debug symbol tables, making it smaller. you would strip all the executable code that is put onto the target
## GCC ar
The `ar` command is primarily used for creating and managing archives, commonly for static libraries in the context of C/C++ development. Here are some common usages and examples:
1. **Creating a new archive (static library)**
```Bash
ar rcs libmylib.a file1.o file2.o file3.o
```
	`s` is an option that creates an archive index (for quicker access to functions in the library).
2. **Listing the contents of an archive**
```Bash
ar t libmylib.a
```
	This will show the object files (*.o) contained within the static library libmylib.a.
3. **Extracting files from an archive**
```BASH
ar x libmylib.a
```
	This will extract all files from `libmylib.a`.
4. **Removing a file from an archive**
```SHELL
ar d libmylib.a file_to_remove.o
```
	This will remove `file_to_remove.o` from `libmylib.a`.
5. **Appending files to an archive**
```SHELL
ar q libmylib.a new_file.o
```
	The `q` option is for quick append. This appends `new_file.o` to `libmylib.a` without checking for replacement.
6. **Inserting a file before another file in the archive**
```SHELL
ar r libmylib.a new_file.o before_existing_file.o
````
7. **Updating a file in the archive (if the archive version is older)**
```SHELL
ar u libmylib.a file_to_update.o
````
	If `file_to_update.o` in the system is newer than the one in `libmylib.a`, it will replace it. If not, no changes will be made.
## GCC ldd
`ldd` stands for "list dynamic dependencies." It's a utility on Unix-like systems that prints the shared libraries required by a program or shared library.
-  Basic Usage**:
```BASH
ldd /path/to/your/program
```
    This will list all shared libraries that the program needs to run.
 -  **Check a System Binary**:
```BASH
ldconfig -p
ldd $(which ls)
```
    You can also check what libraries a system utility uses. For example, to see the libraries the `ls` command depends on
- **Verbose Output**:
```SHELL
ldd -v /path/to/your/program
```
    This will show you the version information for the dynamic linker and each shared library.
- **Data Address and Entry Point**:
```BASH
ldd -r /path/to/your/program
```
    Use the `-r` option to show the program's data address and entry point:
- **List All Missing Objects**:
```BASH
ldd -d /path/to/your/program
````
    Use the `-d` option to list all missing objects:
## GCC ldd
You can verify which libraries have been linked in this or any other program by using the readelf command:

```
arm-cortex_a8-linux-gnueabihf-readelf -a myprog | grep "Shared library" 0x00000001 (NEEDED) Shared library: [libm.so.6] 
0x00000001 (NEEDED) Shared library: [libc.so.6]
```
## Static And Dynamic Library
### Static Library

A static library, sometimes known as an archive, is a single file that contains a collection of object files. When a program is linked against a static library, the machine code from the relevant object files in the static library is directly incorporated into the final executable.

**Benefits of Using Static Libraries:**
	- **Portability**: Since all the code the executable needs is included during the linking phase, the executable can run on any system without requiring additional libraries.
	- **Performance**: There's a slight performance benefit because the code is already in the executable and doesn't need to be dynamically loaded.

**Drawbacks of Using Static Libraries:**
	- **Size**: Every program linked with the static library will contain its own copy of the library code, leading to larger executable sizes.
	- **Updates**: If the library is updated, all programs using it need to be relinked and redistributed to benefit from the changes.
#### Make Your Static Library

1- Compile  and Assemble Library C File And Make Object File

```BASH
gcc -c File.c -o File.o
```
-c: Make ObjectFile Do Not Link
-o: Define Output

2- Compile All Objects File In One .a File in Case of Static and . as in case of dynamic

```BASH
ar rc My_Lib.a File.o
```
`r` Replace existing or insert new file(s) into the archive.
`c` Create the archive.

3- Compile Wanted File But With Static Lib i Made

```SHELL
g++ Main.cpp -L. -lMy_Lib -o Main
```
`-L.` Adds the current directory to the library search path.
`lMy_Lib` Tells the linker to look for a library named `libMy_Lib.a` (or `libMy_Lib.so` for shared libraries) in the directories listed in the library search path.
#### Notes

```bash
### Default Include Paths:
g++ -E -x c++ - -v < /dev/null 2>&1 | grep '^ /'
#### Default Library Paths:
g++ -E -x c++ - -v < /dev/null 2>&1 | grep '^LIBRARY_PATH'
### System Include Directories:
g++ -E -x c++ - -v < /dev/null 2>&1 | grep '^ /' | grep '/include'
### System Library Directories:
g++ -E -x c++ - -v < /dev/null 2>&1 | grep '^LIBRARY_PATH' | sed 's/=/ /g' | awk '{print $2}'
```

### Dynamic Library
  
Dynamic libraries (often known as shared libraries) are libraries that are loaded at runtime, either when the program starts or in some cases when a particular functionality is called for the first time. This is in contrast to static libraries, which are linked into the program at compile time. Using dynamic libraries can save memory because several running applications can share a single copy of the library. It also allows one to update the library without recompiling the programs that use it, provided that the interface to the library does not change.

**Benefits of Using Dynamic Libraries:** - **Memory Efficiency**: Multiple programs can share the same library in memory. - **Updateability**: You can patch or update the library without recompiling the programs that use it (though you must ensure binary compatibility). 

**Drawbacks of Using Dynamic Libraries:** - **Startup Time**: It might take a bit longer to start a program because the system needs to load and link the shared libraries. - **Dependency**: If a shared library is missing, moved, or an incompatible version, the program will not run.

To compile and create a dynamic library, you can use the following commands:
```BASH
gcc -c -fPIC <File_Name>.cpp -o <File_Name>.o
gcc -shared -o lib<File_Name>.so <File_Name>.o
ldd <application>
```

If you want the system to look for libraries in other directories as well, you can update the `LD_LIBRARY_PATH` shell variable. Add a colon-separated list of paths to `LD_LIBRARY_PATH`:

```BASH
export LD_LIBRARY_PATH=<Path>:$LD_LIBRARY_PATH
```

The `LD_LIBRARY_PATH` environment variable serves as a list of directories where the dynamic linker searches for shared libraries. Additionally, the system maintains a dynamic linker cache (`/etc/ld.so.cache`) to provide a faster method of locating libraries. To add a directory to the dynamic linker cache, you can edit the `/etc/ld.so.conf` file and then run the following command:

```BASH
#Build Cash Binary
ldconfig 
#Show All Dynamic Libs
ldconfig -d
#Build Cash With Addition Path
Idconfig <path>
```

This command updates the dynamic linker run-time bindings and includes the specified directories in the cache.
# References:

1- [Build Image Raspberry](https://hechao.li/2021/12/20/Boot-Raspberry-Pi-4-Using-uboot-and-Initramfs/)
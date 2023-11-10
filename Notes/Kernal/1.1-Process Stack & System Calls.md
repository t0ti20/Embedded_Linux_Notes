## 📃 Definition

- **System Calls**: They serve as an interface between a process and the operating system. When a system call is invoked, the kernel saves the context of the user space, switches to kernel space, locates the appropriate function via the system call table, executes it, then restores the user context after returning the result.
- **Process**: A process can be defined as an instance of a program in execution. It comprises the program code, current activity, and a set of resources in use. Processes reside in memory.

![[Pasted image 20231006093644.png]]

## ✅ Terms

- **System Calls**: Functions the program uses to request a service from the kernel.
- **glibc**: The GNU C Library – Provides the system call interface functions for many programming languages.
- **System Call Table**: It is a table in the kernel that maps system call numbers to the functions that implement those calls.
- **Result vs Status**: While a "result" generally refers to the output or the value returned after performing an operation, "status" often refers to the state or condition after an operation (e.g., success or failure).
- **Program**: A set of instructions written to perform a specific task.
- **Priority**: It dictates the order in which processes are scheduled to run.
- **Signal**: A limited form of inter-process communication used in Unix-like operating systems.
- **Child Process**: A process spawned by another process (the parent).
- **Parent Process**: A process that has spawned one or more child processes.
- **Context Switching**: When the CPU switches from executing one task to another.
- **Daemon Process**: Background processes that run continuously.
- **Zombie Process**: Processes that have completed execution but are still in the process table.
- **Orphan Process**: Child processes whose parent process has completed.
- **Inter Process Communication (IPC)**: Mechanisms like shared memory, pipes, and message queues that allow processes to communicate.
- **Chroot**: A system call used to change the root directory, often used for isolation.
- **LD_PRELOAD**: An environment variable for overriding the functionality of one or more system calls.

## 🔃 Operations

- **Invoke system calls**: Using a specified number associated with every system call, the call is made, which in turn looks up the system call table to find the corresponding function.
- **Run and Create Process**: `fork()`, `exec()`, and `clone()` are system calls to create processes.
- **Terminate Process**: Processes can be terminated using system calls like `exit()`.
- **Change Process Priority**: Adjust a process's priority to influence its scheduling using `nice()` and `renice()`.
- **Trace Process**: `strace` helps to trace system calls and signals.
- **Send Information To Another Process (Signal)**: `kill` command is often used to send signals to processes.

## 📂 Files Of Interactions

- **Table**: System call table for x86_64 architecture. -> `arch/x86/entry/syscalls/syscall_64.tbl`
- **Process Location**: `/proc/` directory contains a pseudo-filesystem that provides an interface to kernel data structures.

## ⚙️ Commands

- `strace`: Troubleshooting tool for tracing system calls.
- `uname`: Print details about the current machine and the operating system running on it.
- `man`: Format and display manual pages.
- `tldr`: Display simple help pages for command-line tools from the tldr-pages project.
- `errno`: Look up errno names and descriptions.
- `fg` and `bg`: Manage background and foreground processes.
		![[Pasted image 20231006094219.png]]
- `kill`: Sends a signal to a process, usually related to stopping the process.
- `nice`: Execute a program with a custom scheduling priority (niceness). Niceness values range from -20 (highest priority) to 19 (lowest).
- `renice`: Alters the scheduling priority/niceness of one or more running processes.
- `pstree`: A tool to show running processes as a tree.
- `top`: Display dynamic real-time information about running processes.
- `ps`: Information about running processes.

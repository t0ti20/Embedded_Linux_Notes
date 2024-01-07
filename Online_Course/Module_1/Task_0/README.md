### What does kernel mean?

- The kernel is the central component of an operating system.
- It is responsible for managing low-level tasks and interacting with the hardware components of a computer system.
- The kernel provides essential services, such as process management, memory management, and input/output operations.
- It acts as a bridge between the hardware and the software layers, ensuring that different software components can run efficiently and securely.

### What does Operating System mean?

- The operating system (OS) is a comprehensive software package that manages the hardware and software resources of a computer system.
- It includes the kernel, which is the core part responsible for low-level operations.
- The operating system provides a user interface, system utilities, libraries, and applications to enable users to interact with the computer.
- It facilitates the execution of programs, manages file systems, controls input/output devices, and ensures the overall stability and security of the system.

### Is Linux a kernel OR operating system?

Linux is a kernel, and when used in the context of an operating system, it usually refers to a Linux distribution that includes the Linux kernel along with additional software components to form a complete and usable system.

### What is an Architecture Layer Diagram?

A way that stakeholders can understand the system's structure, make design decisions, and communicate effectively about the software's organization.

### What is user space?

Portion of a computer's memory where user-level applications run. It is where everyday applications, like word processors and web browsers, execute and interact with the operating system through system calls, maintaining security and stability.

### What is kernel space?

Kernel space is the privileged part of a computer's memory where the operating system's core functions, critical processes, and device drivers operate. It has direct access to hardware and handles essential tasks, distinct from the user space where applications run.

### Describe Main Layers for Linux kernel?

Linux kernel is often simplified into these main layers: User Space, Kernel Space, Device Drivers, and Hardware. Each layer has specific responsibilities in managing and interacting with the underlying system components.

### Identify the Purpose for each Layer?

#### User Space:
This is where user-level applications run. It is a restricted environment where applications operate, and they communicate with the kernel through system calls.

#### Kernel Space:
The core of the operating system resides here. It contains critical components like process management, memory management, and file systems. It runs in privileged mode with direct access to hardware, handling essential tasks to ensure the proper functioning of the system.

#### Device Drivers:
Device drivers bridge the gap between the kernel and hardware devices. They provide a standardized interface for the kernel to communicate with various hardware components, allowing the operating system to manage and control hardware resources.

#### Hardware:
This layer consists of physical computing components such as the CPU, memory, disk drives, and peripherals. The hardware interacts with the kernel through device drivers, enabling the operating system to utilize and control the underlying hardware resources.

### Identify how each layer interacts with the lower one?

#### User Space → Kernel Space:
User-level applications interact with the kernel by making system calls. These system calls act as a bridge, allowing applications in user space to request services and resources from the kernel in kernel space.

#### Kernel Space → Device Drivers:
The kernel interacts with device drivers to communicate with hardware. Device drivers provide a standardized interface for the kernel to manage and control different hardware components.

#### Device Drivers → Hardware:
Device drivers interact directly with the hardware by sending commands and receiving data. They provide an abstraction layer, translating generic kernel-level commands into specific instructions for the hardware.

#### Hardware → Device Drivers:
Hardware communicates with device drivers by triggering interrupts or responding to commands sent by the drivers. Device drivers interpret these signals and facilitate communication between the hardware and the kernel.

#### Device Drivers → Kernel Space:
Device drivers communicate with the kernel by sending and receiving data through predefined interfaces. They provide services to the kernel, allowing it to manage and control various hardware components.

#### Kernel Space → User Space:
The kernel responds to system calls initiated by user-level applications. It provides requested services, such as process management, memory allocation, or file system access, allowing user space applications to operate by signals.

### What is Glibc Library?

GNU C Library (glibc) is a crucial software library for Unix-like operating systems, including Linux. It provides essential functions for C language programs, abstracts system calls, supports internationalization, includes a dynamic linker, facilitates multithreading, and offers compatibility across various Unix systems. Glibc is a fundamental component of the GNU operating system and contributes to the portability and functionality of C-based applications.

### What does command mean?

A command is a text-based instruction provided by a user to a computer or software, typically through a command-line interface, to perform a specific action or task.
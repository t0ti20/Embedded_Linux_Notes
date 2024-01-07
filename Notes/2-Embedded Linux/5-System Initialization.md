## System Initialization: systemd vs. Sysvinit
### Overview:

To initialize a system, you have two main choices: **systemd** and **Sysvinit**. The selection often depends on the preferences of distribution maintainers and the specific needs of system administrators.

### 1. systemd:

- **Overview:**
    - systemd is the default init system in many modern Linux distributions.
- **Features:**
    - Parallel startup of system services for faster boot times.
    - Dependency-based service management.
    - Advanced logging and journaling system (systemd-journald).
    - Process tracking using Linux Control Groups (cgroups).
    - Automatic restart of failed services.
    - On-demand starting of services.
    - Compatibility with socket activation (services start when a socket is accessed).
- **Configuration:**
    - Service configuration through unit files in `/etc/systemd/system/`.
- **Commands:**
    - `systemctl`: Control systemd.
    - `journalctl`: Query and display messages from the journal.
- **Used By:**
    - Widely used in major Linux distributions (Fedora, RHEL, CentOS, Ubuntu).

### 2. Sysvinit:

- **Overview:**
    - Sysvinit (System V init) is a traditional init system used in Unix-like operating systems.
- **Features:**
    - Simple and straightforward startup scripts.
    - Configuration through shell scripts in `/etc/init.d/`.
    - Relies on runlevels to define the system state (e.g., single-user mode, multi-user mode).
    - Basic process management without advanced features like cgroups.
- **Configuration:**
    - Configuration through shell scripts in `/etc/init.d/` and symbolic links in `/etc/rc*.d/`.
- **Commands:**
    - `/etc/init.d/`: Directory containing init scripts.
    - `service`: Command to start, stop, and manage services.
    - `update-rc.d`: Command to update runlevel links for services.
- **Used By:**
    - Historically used by many Linux distributions before the widespread adoption of systemd. Some distributions still provide support or variations of Sysvinit.

### Adding a Custom Script:

If you check processes in the system using `ps` or `pstree` and find the init process, you can follow these steps to run init:

1. Navigate to the file `/etc/inittab`.
2. `/etc/inittab` consists of runlevels in the system.
3. Each runlevel runs specific scripts found in directories under `/etc/rc*`.
4. Check the current runlevel with `runlevel`.
5. To add a script, select a runlevel, and start your script with `S`, e.g., `S20syslog`.
6. Most scripts are symbolic links to scripts in `init.d`, like `/etc/init.d/scriptname`.

Example Script (`S03Application.sh`):

```BASH
#!/bin/sh
case "$1" in
   start)
      echo "This Is My Start Script Running Under runlevel = 5"
      echo "Starting C Application"
      Hello_World
      ;;
   stop|restart)
      echo "This Is My End Script Running Under runlevel = 5"
      echo "Ending C Application"
      ;;
   *)
      ;;
esac
exit 0
```


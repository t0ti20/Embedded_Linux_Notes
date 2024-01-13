## 📃Definitions
- **User**: An account that represents a person or application accessing a Linux system.
- **Resource**: Systematic allocations such as files, directories, or hardware devices.
- **Process**: A running instance of a program.
- **Permission**: Access rights or rules associated with files and directories.
- **Group**: A set of users sharing the same access rights to certain resources.
- **Superuser**: A user with unrestricted access to all files, commands, and resources in the system, typically known as the root user.
- **UID (User Identifier)**: A unique number assigned to each user for identification.
- **GID (Group Identifier)**: A unique number assigned to each group.

## 🎯 Operations
### - User
- Create User
- Delete User
- Monitor User
- Edit User Data
### - Resources [Files]
- Access file
- Change resource permission
### - Groups
- Create Group
- Delete Group
- Monitor Group
- Edit Group Data

### - Password Operations
- Setting/Changing Password
- Locking/Unlocking User Account

### - Policy Management
- User Expiry
- Password Expiry

## ⚙️ Commands
- `useradd`: Create a new user.
- `su`: Switch shell to another user.
- `id`: Print user and group information for each specified USER.
- `chmod`: Change the access permissions of a file or directory.
- `chgrp`: Change group ownership of files and directories.
- `usermod`: Modify a user account.
- `groupadd`: Add user groups to the system.
- `chown`: Change user and group ownership of files and directories.
- `w`: Show who is logged on and what they are doing.
- `passwd`: Change a user's password or lock/unlock a user account.
- `groups`: Display group memberships for a user.
- `gpasswd`: Administer `/etc/group` and `/etc/gshadow` (e.g., adding/removing users from groups).
- `getent`: Fetch entries from Name Service Switch libraries.
- `userdel`: Delete a user account and related files.
- `wc`(Word Count): Count lines, words, and bytes..
- `du`(Disk Usage): estimate and summarize file and directory space usage.
- `strings`: Find printable strings in an object file or binary.
- `scp`(Secure Copy): Copy files between hosts using Secure Copy Protocol over SSH.
- `more`: Open a file for interactive reading, allowing scrolling and search.
- `find`: Find files or directories under the given directory tree, recursively.
- `whatis`:  Display one-line manual page descriptions

## 📁 Files
- `/etc/passwd`: Contains user account information.
- `/etc/group`: Contains group account information.
- `/etc/shadow`: Contains encrypted passwords and other details (only readable by the superuser).
- `/etc/sudoers`: Defines which users can run specific commands and where.
- `/etc/login.defs`: Configuration for the shadow password suite.

## 📝 Notes
- Always exercise caution when working as a superuser (`root`). A minor mistake can result in major consequences.
- Regularly backup essential user management files, particularly before making significant changes.
- Test major changes in a safe environment first.
- Monitor log files such as `/var/log/auth.log` or `/var/log/secure` for login attempts and other security events.
- `strace -e trace=file command-to-run` is useful for seeing what files a command accesses.
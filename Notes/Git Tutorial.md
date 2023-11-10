### **1. Introduction to Git**
- **Definition**: Git is a distributed source control system.
- **Open Source**: It's freely available for modification and redistribution.
- **History**: Developed to meet the requirements of the Linux project.
- **Performance**: Known for being very fast.
- **Community**: Git boasts an active and supportive developer community.

### **2. Git Workflow Overview**
1. **Origin**: This is typically your starting point.
	1. **Working Directory**: The location where you make changes to your code.
	2. **Staging Area**: Where you track changes (using `git add`).
	3. **Repository**: Where commits are stored (using `git commit`).
2. **Remote**: The remote server where your code resides (status can be checked using `git status`).

### **3. Key Git Commands**

- **Setup and Initialization**
``` SHELL
# Initialize a new Git repository.
git init   
# Copy an existing local repository.
git clone '/path/to/repository'   
# Copy a repository from a remote server.
git clone username@host:'/path/to/repository'   
```  

- **Configuration**
``` SHELL
# Set up email for GitHub.
git config --global user.email "t0ti20@mail.com" 
# Set up username for GitHub.
git config --global user.name "Khaled El-Sayed"   
```  

- **Remote Operations**
``` SHELL
git remote add origin <server>   
# Link your local repo to a remote server.
git push origin master   
# Push local repo changes to a remote repository.
git pull   
# Update local repo to the newest commit from a remote.
git fetch  
# Fetch the changes from a remote without merging them.
```    
- **Branching**
```SHELL
git checkout -b feature_x   
# Create and switch to a new branch named "feature_x".
git checkout master   
# Switch back to the master branch.
git branch -d feature_x   
# Delete "feature_x" branch.
git push origin feature_x   
# Push "feature_x" branch to the remote repository.
git merge feature_x   
# Merge "feature_x" branch into the current branch.
```

- **Staging, Committing, and Ignoring**
```SHELL
git add <filename>   
# Add a file or changes to the staging area.
git commit -m "Descriptive commit message"   
# Commit your changes with a message.
# To exclude specific files/folders from commits, create a ".gitignore" file in the root directory and list them.
```

- **Review, History, and Other Utilities**
```SHELL
git diff <source_branch> <target_branch>   
# View differences between two branches.
git log   
# View the repository's commit history.
git stash   
# Temporarily store changes that you don’t want to commit immediately.
git reset   
# Reset your repo, discarding certain changes.
```

- **Reset local git repository to same like remote**
```SHELL
git fetch origin
# First, get latest changes from the remote
git reset --hard origin/master
# Second, hard reset the branch.
git clean -d -f -x 
# Last step is to remove all the untracked files (-f) and directories (-d), plus ignored files (-x).

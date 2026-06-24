############## GITFLOW PRINCIPLES 3########################
A branch-heavy model with long-lived branches.
GitFlow is suitable for large teams with scheduled releases and strict QA processes.

With the git repo initialized, and the default branch renamed to main,
git branch -M main


set up your email and name with the following commands:

git config --global user.email "email@example.com"

git config --global user.name "First Last"


# Branch name for Production Release - Master / main
Branch name for next release development - development
Feature Branch - feature
Bugfix branch  - bugfix
Release Branch - release
Hotfix Branch - hotfix
Support Branch - support


## git GitFlow extension need to be pre-installed using the apt install git-flow command (for ubuntu)

## create the GitFlow branch structure using the GitFlow git extension:

git flow init 
 
#The main branch often contains code for production–in GitFlow especially,
 commits should never be made directly to the main branch.
 
# lists the existing feature branches with the following command:
git flow feature 


git flow feature start 123-show-password-on-login-page

# The code is ready to merge with the develop branch. Do this by executing the finish command in GitFlow:

git flow feature finish 123-show-password-on-login-page
 
 
feature/123-show-password-on-login-page

But the command omits the leading feature/. You should see text indicating that the feature branch was merged to develop, and that the feature branch was deleted. 


##### Implement a release with GitFlow by using the release aspect of GitFlow: 

git flow feature start 123-implement-multifactor-auth

echo 'Implementing multi-factor authentication' > code2.txt

git add code2.txt

git commit -m 'Implemented multi-factor'

git flow feature finish 123-implement-multifactor-auth

#This is the first release–to confirm this, issue the following command to list the releases:

git flow release

# A release will represent a merge of the develop branch to a new short-lived release branch. Perform this with the following command:

git flow release start 2026-03-02

Execute the following command:

git log


## Two weeks have passed and it's time to perform a new release. The old release has been stable during this time, so it’s time to finish the release in advance of creating a new one. Issue the following command:

git flow release finish '2026-03-02' -m 'Stable in advance of 2026-03-16 release'


The release branch has been merged to main. Issue the following command:

git branch

###
Note: If a problem had arisen in between releases, you could use the hotfix branch. With a hotfix, a new branch is created from the release branch, where you can perform whatever new work is necessary to fix and test the code. Once the hotfix is complete, it is merged to BOTH the develop and the release branches, so that you can release the fix and integrate the fix with ongoing work.

####################################################################################################

2️⃣ Trunk-Based Development (TBD)
Developers commit directly or very frequently to a single branch (main or trunk).
Trunk-based development is ideal for high-maturity DevOps teams practicing continuous deployment.

Short-lived branches (hours, not days)
Small, frequent commits
Feature flags instead of long branches

How it works
Code merged to main daily
CI runs on every commit
Production is always deployable

Pros
✅ Fast deployments
✅ Less merge conflict
✅ Strong CI/CD alignment


> There is no one-size-fits-all. GitFlow suits release-driven products, Trunk-Based suits continuous deployment, and GitHub Flow is a lightweight PR-based model for fast-moving teams.

GitFlow → more manual approvals, slower pipelines
Trunk-Based → strongest CI/CD automation
GitHub Flow → best balance of simplicity + control


##################### Implement Semantic Versioning Principles #####################

Semantic Versioning (SemVer) is a versioning system used to manage and communicate changes in software projects. It helps developers and users understand the type and impact of changes made in different releases of a software package. The goal of Semantic Versioning is to give developers a clear and consistent way to express backward compatibility and new features.

1.Version Format: The version number is made up of three segments:

Copy

MAJOR.MINOR.PATCH

MAJOR version: Incremented when there are backward-incompatible changes. This typically means breaking changes.
MINOR version: Incremented when new features are added in a backward-compatible way (i.e., it doesn’t break existing functionality).
PATCH version: Incremented for backward-compatible bug fixes or patches (i.e., fixing errors without changing functionality).


2.Pre-release and Build Metadata: You can append additional labels to indicate pre-release versions or build metadata:

Pre-release versions: Indicated by a hyphen, e.g., 1.2.0-alpha, to show that it is not the final stable release.
Build metadata: Appended with a plus sign, e.g., 1.2.0+20130313144700.

3. Backwards Compatibility:
If a new version includes backward-compatible changes, it increments the MINOR or PATCH version.
If a new version includes breaking changes that break backward compatibility, it increments the MAJOR version.

Example:
1.2.3 → 1.3.0: A new feature was added in a backward-compatible way.
1.3.0 → 2.0.0: A breaking change was introduced.
2.0.0 → 2.0.1: A bug fix that doesn’t break compatibility.
 
## Why Use Semantic Versioning?
Clarity: Helps consumers of the software know whether upgrading is safe (e.g., if it’s a major version, they should review the release notes carefully).
Compatibility: Assists in determining whether existing code will still work with a new version, and whether there are new features available.
 

tag the commit with the version tag:

git tag -a v1.0.1 -m 'Payload comparison bug corrected'

git tag - for reviewing the tags 

 

you can create a .gitignore file (with vi command)to manage what gets included in your repository. In real-world software development, .gitignore files are commonly used to exclude files that are not relevant to the source code, such as build artifacts, log files, or personal configuration files. This helps keep the repository clean and ensures that only necessary files are tracked and shared with other team members.
vi .gitignore 

Add entries to exclude specific files and directories, in this case logs and temporary files:

logs/
*.tmp

git add .gitignore
git commit -m "Add .gitignore file"

git log --oneline
 
The --oneline argument condenses each commit in the log to a single line, showing the commit hash and the commit message. This view is particularly useful for getting a quick overview of your commit history, making it easier to visualize the sequence of changes in your project.

Delete the feature-branch now that it has been merged:
git branch -D feature-branch
 
 Deleting the feature branch after merging is a good practice to avoid clutter in your repository. Since the branch has been fully integrated into main, it’s no longer needed. This prepares your repository for the next challenge, ensuring that you start with a clean state.
 
While Merging the any branch (A1) to master, you need to be in master branch then run below command
git merge A1

### Resolve COnflict in files ##

Captain's log: Initiating mission to explore the unknown regions of space.
Captain's log: Encountered an asteroid field, navigating through safely.
<<<<<<< HEAD
Captain's log: The crew has reported an unidentified object approaching.
=======
Captain's log: Discovered a hidden space station.
>>>>>>> feature-branch-conflict

##########################################
The content between <<<<<<< HEAD and ======= is what exists in the current branch (main), while the content between ======= and >>>>>>> feature-branch-conflict is from the branch you are merging (feature-branch-conflict). To resolve the conflict, you need to decide how to combine or choose between these changes.
 
 
 <<<<<<< HEAD: This marks the beginning of the changes from the current branch (in this case, main).

=======: This separates the conflicting changes between the two branches.

>>>>>>> feature-branch-conflict: This marks the beginning of the changes from the branch being merged (in this case, feature-branch-conflict).

Resolve the conflict by, in this case, removing the lines with special markers, and keeping all lines:


_____________________________________________________________________________

pslearner@ip-172-31-24-30:~/Documents/SpaceAdventure$ git log --graph --oneline
*   2259699 (HEAD -> master) Resolve merge conflict in adventure log
|\  
| * f5c3742 (feature-branch-conflict) Add hidden space station discovery to adventure log
* | 298057f Report unidentified object in adventure log
|/  
* 1a1717a Add mission log
* f2c642a Add .gitignore file
* 7dd764d Update adventure log
* dc42744 Add initial adventure log
_____________________________________________________________________________


 Branch Merges: The lines and asterisks (*) on the left represent the branching and merging of commits. The diagonal lines (/ and \) indicate where branches diverged and where they were merged back together.

Commit Messages: Each line shows a condensed version of the commit hash followed by the commit message. For example, the commit with the message Resolve merge conflict in adventure log is the most recent commit on the main branch.

Branch Labels: You can see that HEAD -> main is currently pointing to the latest commit. The commit from the feature-branch-conflict is also labeled, showing where the branch was merged.

Commit Sequence: The history shows how changes were integrated from different branches. The separate lines indicate parallel development work in the branches, and the convergence back into a single line shows where those branches were merged.

This visual log is particularly useful for understanding the relationship between branches and how your commits have been integrated over time. It provides a clear overview of how multiple lines of development have come together, making it easier to track the progression of your project.
 
 _____________________________________________________________________________

 git init --bare SpaceAdventure-Bare
 A bare repository doesn’t have a working directory (so, you won’t see the usual files and folders). Instead, it’s designed to be a central repository where collaborators can push and pull changes. This is ideal for simulating a shared repository in a collaborative environment.
 When working in the real world, bare repositories aren't often used. Instead, a common approach is to use a git hosting solution such as GitHub, GitLab, and Bitbucket, to host the centralized version of the repository. As you work through this challenge, you can think of the SpaceAdventure-Bare repository being similar to these hosted solutions.
 
 
 git pull origin master
 git config pull.rebase false
 git pull origin master
 By setting pull.rebase to false, you're telling Git to use the "merge" strategy when pulling changes from the remote repository. This strategy merges the changes from the remote branch into your local branch, creating a new merge commit that contains both sets of changes. This is the most common method of resolving divergent branches.
 
 code .  --->> command to open Visual code from git terminal
 
 
 Welcome to the Final Challenge!

This is your last chance to experiment in the environment. Clicking Finish Lab will end this little world that flittered into existence just for you.

Take this opportunity to try new things. Don't be afraid to break anything; be curious!

Here are some things to try out:

Create a new branch and implement a small feature, then merge it back into the main branch.

Simulate a more complex merge conflict by having multiple team members (directories) work on different parts of the same file, and practice resolving the conflicts.

Use git log --graph --oneline to visualize your commit history and explore how your changes are interconnected.

Modify your .gitignore file to exclude certain files or directories and see how it affects your repository tracking.

Try using Git commands you haven’t used yet, such as git stash to temporarily save changes or git rebase to rewrite commit history.


# Why Gitlab CI over Jenkins?
1. Built in CICD - No Need of extra plugins; everything is integrated seamlessly.
2. Easier setup - Just push your code & Gitlab takes care of the rest CICD
3. Better scalability - Runs effortlessly on k8, autoscaling runners as needed.
4. Simplified maintainance - No Managing Jenkins servers, plugins or dependecies
5. Tighter Git integrations - Native support of git reporitoies, issue tracking, merge requests

# When would you rebase?
I use rebase to keep a clean, linear commit history, mainly for local or short-lived feature branches before merging. I avoid rebasing shared or already-pushed branches.


| Action      | Use When                    |
| ----------- | --------------------------- |
| Cherry-pick | One specific commit         |
| Merge       | Full branch integration     |
| Rebase      | Clean history / sync branch |

# When would you cherry-pick?
I use cherry-pick when I need to apply a specific commit from one branch to another without merging the entire branch.
Cherry-pick is ideal for production hotfixes where only a single fix needs to be applied.

# when to use stash?
I use git stash when I need to temporarily save uncommitted changes so I can switch branches or pull updates without committing incomplete work.
| ----------- | --------------- |
| Tool   | Purpose              |
| ------ | -------------------- |
| Stash  | Temporary local save |
| Commit | Permanent history    |
| Branch | Parallel work        |
| ----------- | --------------- |


# What is HEAD ?
In Git, HEAD is a pointer to the current commit that your working directory is based on.
It usually points to the latest commit on the current branch, and it moves as you commit or checkout branches.
    “HEAD points to the tip of the current branch.”
    “Detached HEAD means you are on a specific commit, not a branch.”
    “HEAD moves with commits or branch checkouts.”

# what is Pre-commit hooks?
A pre-commit hook is a script that Git runs before a commit is finalized, allowing you to check or modify code, run tests, or enforce standards, preventing bad commits from entering the repository.

# git reset & git revert
| ----------- | -------------------------------- | -------------------------------- |
| Command     | Purpose                          | Use Case                         |
| ----------- | -------------------------------- | -------------------------------- |
| git reset   | Moves HEAD and optionally changes| Undo local commits or changes.   |
              | the index and working directory  |                                  |
| git revert  | Creates a new commit that undoes | Undo changes in a public history.|
              | the changes of a previous commit |                                  |
| ----------- | -------------------------------- | -------------------------------- |

# git revert
helps in situation of rollback.

# git branch -D
we can delete obsolete branches from our repositiry so that our repo can be light weight

# git mv  
To rename the file in git repo without losing history of that file
In order to save changes , we have to perform commit

# git rm 
To delete the files from git repo
If its done by mistake, then run git revert command to reraver the changes
git rm filename ;  git add . ; git commit -m "delete" 

# git rm --cached fielname
you can delete the file from git repo but file will not be permanently deleted from local repo.
We can easily access the file, even after running this command.

# Difference beween git pull & git fetch
git pull = git fetch + git merge

git pull command pulls new changes or commits from a particular branch from your central repository and updates.

# git log --oneline
recent commits in one line, quick history


# git stash
temporarily saves changes without committing to git

# git rebase -i HEAD~N
Edit, squash or reorder your last N committs

# git cherry-pick <hash>
Copy one specific commit from another branch.

`git blame` is a command that shows the last modification for each line of a file, including the author and the commit hash. 
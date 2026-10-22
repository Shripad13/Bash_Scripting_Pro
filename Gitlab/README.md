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



• variables: Can be static strings or leverage predefined GitLab variables (like $CI_COMMIT_BRANCH or $GITLAB_USER_NAME) to inject dynamic context into your scripts.

• rules vs only/except: rules is the modern approach because it allows powerful, complex logic using if, changes, and exists clauses.


• when: Controls how a job triggers. Common values include always (run no matter what), on_success (default, runs if previous stages passed), manual (awaits a human button click), and never (previces execution entirely).

• environment: Registers your deployment tracking in GitLab, letting you see deployment history and manage rollbacks right from the GitLab operations dashboard.


1. What is GitLab CI/CD and how does it work?
GitLab CI/CD is an integrated automation tool that builds, tests, and deploys code. 
It uses a .gitlab-ci.yml file to define pipelines, jobs, and stages. For instance, you can create a job like 
job1: 
 script: 
    | echo "Hello, GitLab!" 
 
 and define stages such as 
 
 stages: 
  - build 
  - test 
  - deploy. 

  Pipelines trigger automatically on code changes, providing continuous integration
and delivery directly within GitLab

1. What are artifacts and cache in GitLab CI/CD?
Artifacts are files generated by a job (like compiled code) that GitLab
stores for later stages using artifacts: paths: - build/. 

Cache is used to store
dependencies between jobs with cache: paths: - node_modules/, helping
to speed up pipelines by avoiding redundant installations.

6. What is the difference between only, except, rules, and
when?
only and except control when jobs run based on branch names, 
while rules provide more complex conditional logic 
(e.g., rules: if:
'$CI_COMMIT_BRANCH == "develop"' when: manual). 

The when keyword specifies job execution timing, such as on_success, manual, or always


2. What is a GitLab Runner and how do you register one?

A GitLab Runner is an agent that executes jobs from your .gitlab-ci.yml.

You install it via sudo apt install gitlab-runner and register it using sudo gitlab-runner register, supplying your GitLab instance URL and a registration token. 
Runners can use different executors like shell, docker, or kubernetes, depending on your project’s needs.


GitLab CI/CD categorizes runners based on their scope/management level (where they are assigned and who can use them) and their executors (the technical environment where jobs run).


Part 1: Runner Types by Scope (Management Levels)

• Instance Runners (formerly Shared Runners): Managed by the GitLab administrator and available to all projects and groups across the entire GitLab instance. On GitLab.com, these are the GitLab-hosted runners provided out-of-the-box with monthly free minutes.

• Group Runners: Available to all projects and subgroups contained within a specific group or organization. Perfect for sharing specialized tools or internal infrastructure across multiple related repositories within a team or department.

• Project-Specific Runners: Tied exclusively to a single, individual project. Commonly used for specialized builds, strict security/compliance requirements, or heavy proprietary workloads that need dedicated compute resources.



Part 2: Common Runner Executors (Execution Environments)

The executor defines the specific host environment where the runner actually executes your pipeline job scripts.

• Docker Executor: Runs each job inside a fresh, isolated Docker container using a predefined image. This is the industry standard for reproducibility and security.

• Kubernetes Executor: Dynamically spins up a new pod inside a Kubernetes cluster for every single job, making it ideal for massive enterprise scaling and heavy autoscaling workloads.

• Shell Executor: Executes commands directly on the host machine where the GitLab Runner application is installed. Useful for simple tasks or when you need persistent local environment states, though it lacks strict container isolation.

• Instance / Virtual Machine Executor: Provisions pristine virtual machines or cloud instances on-demand for jobs requiring deep OS or low-level hardware access.

• SSH Executor: Connects to and executes commands on a separate, pre-existing external server via SSH.

3. How can you set environment variables in GitLab pipelines?
Environment variables can be set inside .gitlab-ci.yml under the variables section 
(for example, APP_ENV: "production") or through the GitLab UI
under Settings ➔ CI/CD ➔ Variables. You can then access them within your jobs, like echo $APP_ENV, to securely manage credentials and configurations.


4. How do you trigger pipelines manually and automatically in GitLab?
Pipelines automatically trigger on pushes or merge requests.

To manually start a pipeline, use the GitLab UI (CI/CD ➔ Pipelines ➔ Run Pipeline) or

trigger via API using a curl command like curl --request POST --form
"token=TRIGGER_TOKEN" --form ref=main
https://gitlab.com/api/v4/projects/PROJECT_ID/trigger/pipeline.


7. How do you implement Multi-Project Pipelines?
Multi-Project Pipelines allow triggering a pipeline in another project. 

Inside .gitlab-ci.yml, use the trigger keyword, like 
trigger: 
 project: other group/other-project 
branch: main
 ensuring your runners and permissions are properly configured for secure and smooth execution.

8. What are GitLab Environments and how do you use them?
GitLab Environments represent deployment targets (like staging or production). 

You define environments within a job (e.g., 
environment: 
 name: production 
 url: https://example.com
 
  to track deployments, monitor
live applications, and control production releases with manual approvals. 

9. How do you set up Auto DevOps in GitLab?
 Auto DevOps enables fully automated build, test, and deployment
pipelines without needing a custom .gitlab-ci.yml. 

Enable it from Settings ➔ CI/CD ➔ Auto DevOps. 
GitLab auto-detects your app type and configures appropriate CI/CD pipelines, especially when integrated with Kubernetes clusters

10. How do you manage secrets in GitLab pipelines?

Secrets such as API keys and credentials should be stored securely as CI/CD Variables under Settings ➔ CI/CD ➔ Variables. 
You can reference them within your jobs (echo $AWS_ACCESS_KEY_ID). 
For enterprise-grade security, GitLab also integrates with external Vault solutions for dynamic
secrets management.


1. CI/CD Job Rules (rules:)

Used inside your .gitlab-ci.yml file, the rules keyword is a list of conditions evaluated sequentially. The first rule that evaluates to true determines if the job runs or is skipped. It has effectively replaced the older only/except syntax.
You can combine three main clauses using && (AND) or || (OR) operators:
• if: Checks the value of GitLab CI/CD variables (e.g., checking branch names or pipeline sources).
• changes: Looks at whether specific files or paths were modified in the commit.
• exists: Checks if specific files exist in the repository.


> The image keyword in GitLab CI/CD specifies the Docker image that the GitLab Runner uses to execute a job's script.

---
  deploy_special:
    stage: deploy
    image: alpine:latest  # Overrides the global default for this job only
    script:
      - ./deploy.sh
---



job_name:
  script: echo "Deploying app..."
  rules:
    # 1. Do not run if it's a draft merge request
    - if: '$CI_MERGE_REQUEST_TITLE =~ /^Draft:/'
      when: never
    # 2. Run manually if a Dockerfile changed in a merge request
    - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
      changes:
        - Dockerfile
      when: manual
      allow_failure: true
    # 3. Default: run automatically on the main branch
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: on_success



2. Workflow Rules (workflow:rules)

While standard rules apply to individual jobs, workflow:rules are applied at the global pipeline level. They dictate whether an entire pipeline is created. This is heavily used to prevent duplicate pipelines (such as when a branch push and a merge request event happen at the same time)



3. Repository & Compliance Rules

Outside of CI/CD pipelines, GitLab uses rules to manage permissions and secure code quality:
• Branch Rules: Define who can push or merge to specific branches (e.g., protecting main), force-push controls, and code owner restrictions.
• Merge Request Approval Rules: Specify how many approvals (and from which eligible users or groups) an MR must receive before it can be merged.
• Push Rules: Server-side Git blocks that reject commits if they don't comply with company formatting (e.g., banning filenames, requiring signed commits, or enforcing specific regex formatting on commit messages)




# core best practices for building an efficient, reliable, and secure GitLab CI/CD pipeline:


1. Speed & Pipeline Optimization

• Keep builds fast: Aim for total pipeline runtimes under 10 minutes to maintain rapid developer feedback loops.

• Use the needs keyword: Break free from strict stage-by-stage bottlenecks. Using needs: allows a job to start as soon as its specific upstream dependencies finish, rather than waiting for an entire stage to complete.

• Cache dependencies properly: Speed up jobs (like npm ci, pip install, or mvn install) by defining a smart cache: path for package directories (e.g., node_modules/) scoped by branch or lockfile hash.

• Use custom or pre-built Docker images: Avoid installing heavy system or language packages inside your script: blocks on every run. Instead, use or build custom base images containing pre-installed dependencies.



2. Architecture & Maintainability

• Modularize with Parent-Child or Components: For large codebases or monorepos, split monolithic .gitlab-ci.yml files into smaller parent-child pipelines using trigger: include or reuse modular logic via GitLab CI/CD Components.

• Standardize job keyword order: Keep your YAML readable across teams by ordering keywords chronologically or logically (e.g., extends, stage, needs, rules, tags, image, script).

• Use artifacts for inter-job passing: Only pass compiled binaries or test reports between stages using artifacts:, keeping file transfers lightweight and time-bound with short expiration dates (e.g., expire_in: 1 day).


3. Security & Secrets Management

• Never hardcode secrets: Keep API keys, passwords, and tokens out of .gitlab-ci.yml and repository files.

• Protect and mask variables: Mark sensitive CI/CD variables as Protected (restricted to protected branches/tags) and Masked (hidden from job logs) in your GitLab project settings.

• Use least-privilege job tokens: Restrict CI_JOB_TOKEN scopes and never run untrusted code on deployment-enabled or shell-executor runners.

• Automate DevSecOps early: Integrate SAST (Static Application Security Testing), dependency scanning, and secret detection into early pipeline stages to fail fast on vulnerabilities.


4. Reliability & Deployment

• Enforce quality gates: Require unit tests, security scans, and mandatory Merge Request Approvals to pass before code can merge into main or deploy to production.

• Implement progressive delivery: Use canary deployments or blue/green patterns to test releases on a small subset of live traffic before rolling out globally.

• Pin dependencies and images: Avoid floating tags (like latest) in Docker images or package managers; pin explicit version tags or digests so builds remain reproducible over time.

"We use Jenkins version 2.479.1 (or 2.541.x) because we strictly use the LTS (Long-Term Support) release to ensure stability and compatibility with our plugins."

requirements for jenkins setup -
Memory 1-2 GB
CPU - 2 cores
OS - Linux (RHEL/CentOS/Ubuntu)
Disk space - 10 GB (minimum)
Java - Java 8 or Java 11 (depending on Jenkins version)
Javae - java 17 or Java 21 to run correctly
Java Development Kit - JDK - is preferred for developers,
 while JRE is sufficient for standard hosting
Default Port - 8080

Q: Can Jenkins run without Java?
"No, the Jenkins controller cannot run without Java because Jenkins is built on the Java platform. A supported JDK must be installed before starting Jenkins."

Controller (Master): Java is required.
Agent (Node): Java is usually required for traditional Jenkins agents (agent.jar).
but in most Jenkins environments Java is installed on both controller and agents.
Agents typically also need Java if they connect using the standard Jenkins agent mechanism."

Q. what is agent in any jenkins?
A Jenkins agent is a worker machine that executes build, test, and deployment jobs. The Jenkins controller manages and schedules jobs, while agents perform the actual execution and send the results back to the controller."

Q. How does a controller communicate with an agent?
"Typically through SSH or the Jenkins agent protocol using agent.jar. The agent authenticates with the controller and maintains a secure connection for receiving and reporting job execution tasks."

How do you add a agents machine to your jenkins?
1. Prepare the Agent Machine
2. 2. Create a New Node in Jenkins
Log in to Jenkins.
Go to Manage Jenkins → Nodes (or Manage Nodes and Clouds).
Click New Node.
Enter a node name.
Select Permanent Agent.
Click Create.
3. Configure the Agent
Set values such as:
Remote root directory (e.g., /home/jenkins on Linux or C:\Jenkins on Windows)
Labels (used to target jobs to this agent)
Number of executors
Usage (whether it can run any job or only labeled job
4. Launch via SSH (Linux/Unix)
Select Launch agents via SSH.
Enter:
Hostname/IP
SSH credentials
Save and Jenkins will connect automatically.

How master to agent authentication works?
share me in short for interview?
Jenkins authenticates agents using SSH credentials or an agent-specific secret key. The agent presents its credentials when connecting to the controller, and the controller validates them before establishing a secure communication channel for job execution. This ensures that only authorized agents can connect and execute tasks, maintaining the security of the Jenkins environment.

how can you say jenkins to run on a specific node?
In Jenkins, we use labels to control where a job runs. We assign a label to a node (agent) and then configure the job or pipeline to use that label. Jenkins schedules the build on a node that matches the specified label."
pipeline {
    agent {
        label 'linux'
    }

    stages {
        stage('Build') {
            steps {
                sh 'echo Running on Linux node'
            }
        }
    }
}


What is Matrix based authentication on jenkins?
Matrix-based Security (also called Matrix-based Authorization) in Jenkins is a security model that lets you assign specific permissions to users or groups at a very granular level.

What it does
Instead of giving someone full admin access, you can control exactly what they can do, such as:

Read Jenkins
Create jobs
Build jobs
Configure jobs
Delete jobs
Manage nodes/agents
Administer Jenkins


8. What steps would you take to harden a Jenkins instance? 
Answer: 
1. Enable HTTPS for the Jenkins dashboard. 
2. Disable legacy protocols (JNLP3) and use JNLP4. 
3. Limit plugin installations to trusted sources. 
4. Regularly update Jenkins and plugins. 
5. Use the Matrix Authorization Strategy Plugin to fine-tune permissions. 
6. Set up CSRF protection in "Configure Global Security.

Q: What's the difference between Authentication and Authorization?
Authentication verifies who the user is (e.g., LDAP, Active Directory, GitHub login).
Authorization determines what the authenticated user is allowed to do (e.g., Matrix-based security permissions).

what is the default directory on jenkins?
1. Jenkins Home Directory (JENKINS_HOME) - Linux: /var/lib/jenkins
This is where Jenkins stores its configuration, jobs, plugins, logs, and build history.

2. Workspace Directory - Linux: /var/lib/jenkins/workspace
This is where Jenkins checks out source code and runs builds.

How are you managing jenkins backup and restore in your organization?
We back up the Jenkins home directory (JENKINS_HOME) because it contains job configurations, pipelines, plugins, credentials, build history, and system configuration. 
We take **automated daily backups using scheduled scripts** and store them in a remote storage location. 
We also retain multiple backup versions according to our retention policy. For restoration, we install Jenkins, stop the service, restore the backed-up JENKINS_HOME, verify plugin compatibility, and start Jenkins. We periodically perform restore tests in a non-production environment to ensure the backups are usable.

tar -czf jenkins_backup_$(date +%F).tar.gz /var/lib/jenkins
Restore Process :
systemctl stop jenkins
tar -xzf jenkins_backup.tar.gz -C /
systemctl start jenkins


4. How can you declare a variables globally  in jenkins?
Global variables can be defined through Jenkins Global Properties as environment variables, or through a Shared Library for reuse across multiple pipelines. Within a single pipeline, I typically use the environment block.


Q: Difference between environment variables and Shared Library variables?
Environment variables store configuration values and are accessible as OS environment variables.
Shared Library variables are reusable Groovy code or constants shared across multiple Jenkins pipelines.

Q. Can we have POST per stage?
Yes, Jenkins supports post blocks at the stage level as well as the pipeline level. Stage-level post actions run after that particular stage, while pipeline-level post actions run after the entire pipeline execution.

Common post Conditions :
always – runs regardless of result
success – runs if successful
failure – runs if failed

what can be the maximum number of stages that we can have in jenkins?
There is no maximum limit on the number of stages in Jenkins; it is only constrained by system resources and pipeline maintainability best practices."


How are you handling secrets in your jenkins like sonar tokens?
We manage secrets in Jenkins using the Credentials Store. Sensitive values like SonarQube tokens are stored securely as credentials and injected into pipelines using credentials() or withCredentials() so they are never exposed in code or logs.


what is the code quality tool that are you using??
👉 SonarQube is the standard enterprise tool

It provides:
Code quality analysis
Bug detection
Vulnerability scanning
Code coverage integration
Quality gates (pass/fail pipeline control)

Checkout → Build → Unit Tests → SonarQube Scan → Quality Gate → Deploy


Q. How are you managing the jenkins updates?
We manage Jenkins updates in a controlled manner by first testing new versions in a staging environment, taking a full backup of JENKINS_HOME, and then upgrading during a planned maintenance window. After the upgrade, we validate plugins, pipelines, and agent connectivity before rolling it out to production.

Upgrade through package manager:
sudo apt update
sudo apt upgrade jenkins


How are you making terraform run by your jenkins?
We integrate Terraform with Jenkins pipelines by running Terraform CLI commands in stages, using Jenkins agents with Terraform installed, securely injecting cloud credentials, and controlling deployments using plan and approval before apply.

How is the jenkins to AWS authentication works??
Using IAM Role (Best practice in production)
How it works:
Jenkins runs on an EC2 instance or Kubernetes pod
Attach an IAM Role to that instance
AWS automatically provides temporary credentials via metadata service
No static keys needed

Q. what is the SSL technique that you are using in your infra?
"We use TLS 1.2/1.3 with certificates issued from a trusted or internal CA to secure communication between services like Jenkins, APIs, and load balancers, ensuring encrypted and secure data transfer across the infrastructure.

Q. what are all the various plugins have you used so far in jenkins? what is blue ocean plugin?
Git plugin – integrate Git repositories
GitHub plugin – webhooks, PR builds
Blue Ocean plugin – modern UI for managing and viewing pipelines
SonarQube Scanner plugin – static code analysis
AWS Steps plugin – AWS integrations
Email Extension plugin – advanced email alerts
Slack Notification plugin – Slack alerts for pipeline status


Q. what is the time taken by your CICD piepline?
There is no fixed time for a CI/CD pipeline as it varies based 
typically completing within 10-30 minutes for standard applications.

# Factors affecting pipeline time
Number of stages
Size of codebase
Number of test cases
Network speed (artifact downloads, Docker pulls)
Agent performance
External integrations (SonarQube, AWS, etc.)


# How we optimize pipeline time?
Parallel execution of stages
Caching dependencies (Maven/npm)
Using faster agents (high CPU/RAM)
Avoiding unnecessary builds
Using incremental builds
Container caching for Docker layers

Q. How do you handle if any of the job fails?
When a Jenkins job fails, we identify the failed stage through logs, get notified via alerts, analyze the root cause, fix the issue, and re-run or retry the pipeline. For production pipelines, we also implement rollback and notification mechanisms to ensure quick recovery.

what is the paid version of jenkins??
Jenkins is completely open-source and free. However, there is no official paid version of Jenkins. Organizations may pay for enterprise support, managed services, or third-party distributions, but the core Jenkins tool remains free.

Q. How do you configure global security to jenkins?
Global security in Jenkins is configured via Manage Jenkins → Configure Global Security, where we define authentication mechanisms like LDAP or Jenkins user database and authorization strategies like Matrix-based or Role-based access control to manage user permissions."
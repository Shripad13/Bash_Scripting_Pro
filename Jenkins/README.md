
# What is Continuous Integration and Continuous Deployment (CI/CD) in Jenkins?
Continuous Integration (CI) is the practice of automatically building and testing code changes as they are committed to a shared repository. Continuous Deployment (CD) extends this by automatically deploying successful builds to production or staging environments. Jenkins is a popular open-source automation server that facilitates CI/CD by allowing developers to create pipelines that automate the build, test, and deployment processes.

Continuous Deployment - Will be done by Big companies like Netflix, Amazon, Microsoft, MAANG, where every code which is tested & passed will be directly deployed to production without manual intervention.
You should not say continuous deployment in interviews, say continuous delivery.

| Concept               | Production Deployment    |
| --------------------- | ------------------------ |
| Continuous Delivery   | Manual approval required |
| Continuous Deployment | Fully automated          |



## Jenkins -
1. Jenkins is an open-source framework & is a free to use tool.
2. Its been there in industry for almost 2 decades.
3. Product Managed by open-source community.
4. Commercial support by CloudBees.
5. You are responsible for managing & maintaining the Jenkins server/ software.
6. Jenkins has Master & worker node architecture.


## Github Actions-
1. CI Framework on the top of github platform.
2. your repository should be in github.
3. Only free for individual users & public repositories.
4. For enterprise its paid based on usage.
5. Action platform managed by github itself.
6. You are not responsible for managing & maintaining the underlying platform.
7. you can create runners (worker nodes) on your own infra or use github hosted runners.


# What is Groovy in the context of Jenkins?
Groovy is a scripting language used in Jenkins for writing Declarative and Scripted Pipelines. Jenkins uses Groovy for scripting custom pipeline logic, shared libraries, and for advanced pipeline customization.

> Scripted Pipeline: Written in Groovy code, gives full programming flexibility, but can be complex and harder to read.

> Declarative Pipeline: Uses structured, predefined syntax, easier to read and maintain, with built-in error handling and stages.

# How do you define environment variables in a Jenkins Pipeline using Groovy?

pipeline {
    environment {
        MY_VAR = 'value'
    }
    agent any
    stages {
        stage('Example') {
            steps {
                echo "The value is ${env.MY_VAR}"
            }
        }
    }
}

# How do you define a simple Scripted Pipeline in Jenkins using Groovy?

node {
    stage('Build') {
        echo 'Building...'
    }
    stage('Test') {
        echo 'Testing...'
    }
    stage('Deploy') {
        echo 'Deploying...'
    }
}

# What is a shared library in Jenkins?
A shared library is a reusable piece of code stored in a Git repository that can be loaded in multiple Jenkins pipelines using Groovy. It helps in avoiding code duplication across pipelines.
DRY principle & Standardization
# How can you share code across multiple pipelines in Jenkins using Groovy?
Use a Shared Library:
Define your Groovy classes or functions in vars/ or src/ directories.
Load using @Library annotation.

Example:

vars/sayHello.groovy:

def call(name = 'World') {
    echo "Hello, ${name}"
}

Jenkinsfile:

@Library('my-shared-library') _
sayHello('Jenkins User')

# How do you use load to run external Groovy scripts in Scripted Pipelines?

node {
    def myScript = load 'scripts/utility.groovy'
    myScript.doSomething()
}

The script should return a class or closure with the doSomething() function defined.



# How can you catch errors in a Jenkins Scripted Pipeline?
by using a try-catch block to catch errors and immediately stop the pipeline when a failure occurs.

node {
    try {
        stage('Test') {
            error 'Something went wrong!'
        }
    } catch (e) {
        echo "Caught error: ${e.getMessage()}"
    } finally {
        echo 'This always runs'
    }
}

# How do you use when conditions in Declarative Pipelines?

In Jenkins Declarative Pipelines, the when directive allows you to control the execution of pipeline stages based on specific conditions. This enables you to define different actions based on factors like branch name, environment variables, or build status. Multiple conditions can be combined within a single when block, and all must be true for the stage to execute. 

pipeline {
    agent any
    stages {
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying to production...'
            }
        }
    }
}

# What is the difference between sh and bat in Jenkins?
sh: Used to run shell commands on Unix/Linux.
bat: Used to run batch commands on Windows.

# How do you load and use a Groovy script from the @Library in Jenkins?

@Library('my-shared-library') _
import com.mycompany.MyHelper

MyHelper.sayHello()

# What is @library in Jenkins file?
For Shared Libraries which only define Global Variables ( vars/ ), or a Jenkinsfile which only needs a Global Variable, the annotation pattern @Library('my-shared-library') _ may be useful for keeping code concise.

# How can you run parallel stages in Jenkins Groovy script?

stage('Parallel Tasks') {
    parallel {
        stage('Task A') {
            steps {
                echo 'Running Task A'
            }
        }
        stage('Task B') {
            steps {
                echo 'Running Task B'
            }
        }
    }
}

# How do you create dynamic stages in a Scripted Pipeline using Groovy?
You can use a loop to define stages dynamically based on input:
def stages = ['Build', 'Test', 'Deploy']

node {
    stages.each { stageName ->
        stage(stageName) {
            echo "Running stage: ${stageName}"
        }
    }
}

# How do you pass parameters to a Jenkins pipeline and use them in Groovy code?

pipeline {
    agent any
    parameters {
        string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'Target environment')
    }
    stages {
        stage('Show Param') {
            steps {
                echo "Deploying to ${params.ENVIRONMENT}"
            }
        }
    }
}


# How can you retry a failed step in a Jenkins pipeline using Groovy?
retry(3) {
    sh 'some-flaky-command.sh'
}
Retries the command up to 3 times if it fails.

# How do you use credentials securely in a Jenkins pipeline?
To use credentials securely in a Jenkins pipeline, store them as Jenkins credentials, not in the pipeline code, and use the credentials() step to access them within the pipeline. This ensures sensitive information like passwords and API keys are not exposed in the pipeline definition or logs. 

pipeline {
    agent any
    stages {
        stage('Use Credentials') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh 'echo Username: $USER'
                }
            }
        }
    }
}

# What are closures in Groovy, and how are they used in Jenkins pipelines?
A closure is a block of code that can be passed around and executed later. Pipelines use closures heavily — e.g., steps { ... }, stage { ... } are closures.

def greet = { name -> echo "Hello, $name" }
greet('Jenkins')


# How do you create custom steps in a Jenkins Shared Library?
Create a vars file like deployApp.groovy:
def call(String env) {
    echo "Deploying to ${env}"
}

Then call it in your Jenkinsfile:
@Library('my-shared-library') _
deployApp('staging')


# How do you handle post-build actions in a Declarative Pipeline?

pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
    }
    post {
        always {
            echo 'This always runs'
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}

# How can you use input step for manual approval in Jenkins Pipelines?

pipeline {
    agent any
    stages {
        stage('Approval') {
            steps {
                input message: 'Proceed to deploy?', ok: 'Yes'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}



## What Does H Mean in Jenkins Cron?
The H in Jenkins cron syntax stands for “Hash” or “Hashed value”, and it is used to spread out job execution times to avoid overloading the system.

# Why Use H?
Prevents many jobs from starting at exactly the same time (like at 12:00 AM)
Distributes load evenly over time
Especially useful in large Jenkins installations or when you have dozens/hundreds of scheduled jobs

H - Hashed value for load balancing job execution
Benefits - Avoids collisions, spreads load, consistent per job

# PollSCM -
Wehnever Source code or any change in script or if new Commit then only Pipeline will be triggered.
 Ex - triggers { pollSCM ('H */4 * * 1-5') }

# Cronjob in jenkins - it triggers according to schedule
triggers { cron ('H */4 * * 1-5') }


Stages in jenkins are sequence in nature, STAGE1 onlt be executed after STGAE2 completed.
But using Parallel stage we can achieve execution of multiple STAGE same time.


snapshot/backup will be available at this path on server if we loses jenkins
/var/lib/jenkins

# why jenkins is not created for the purpose of continuous deployment?

A typical Jenkins setup may not come with built-in monitoring or automatic rollback features.

Continuous deployment often involves different environments (e.g., dev, staging, production), and setting up Jenkins to handle these environments can require additional plugins, scripts, or integrations with other deployment tools.

Jenkins has to be securely configured to handle things like environment variables, credentials, and infrastructure secrets. The need for proper security setups (like secret management) might make Jenkins users cautious about enabling continuous deployment right away.

Tools like Spinnaker, ArgoCD, or GitLab CI/CD are often used for fully managed continuous deployment pipelines because they come with more built-in features for deploying applications, handling blue/green deployments, canary releases, and rollback strategies.



Jenkins can be used for continuous deployment, but by default, it is more geared toward continuous integration. For CD, it requires additional configuration and might require integrating with other deployment and orchestration tools to handle full lifecycle deployments safely and efficiently.

# how have you implemented CI/CD pipelines in your previous roles, especially using jenkins?
My experience with jenkins included managing & maintaining the build & release pieplines, which involved monitoring Continuous deployment processes Ans resolving deployment failures quickly.
In my previous roles, I built and managed end-to-end CI/CD pipelines in Jenkins using Pipeline-as-Code with Jenkinsfiles. I automated build, test, and deployment stages, integrated unit and security scans, and used webhooks for automatic triggers on code commits. I also implemented Docker-based builds, pushed artifacts to registries, and deployed to Kubernetes or cloud environments using Helm or kubectl. For production releases, I added approval gates, rollback strategies, and notifications. Overall, I used Jenkins to deliver faster, reliable, and repeatable deployments.

# What is Multibranch Pipeline in Jenkins?
A Multibranch Pipeline in Jenkins is a type of pipeline that automatically creates and manages pipelines for  each branch in a source code repository. It scans the repository for branches containing a Jenkinsfile and creates a separate pipeline for each branch, allowing for isolated builds and tests per branch. This is particularly useful for teams practicing Git branching strategies, as it enables continuous integration and delivery workflows tailored to each branch without manual configuration. 
use Webhooks to trigger builds on code changes.

# How do you set up a Multibranch Pipeline in Jenkins?
To set up a Multibranch Pipeline in Jenkins, follow these steps:
1. Install the Multibranch Pipeline Plugin: Ensure that the Multibranch Pipeline plugin is installed in your Jenkins instance.
2. Create a New Multibranch Pipeline Job: In Jenkins, click on "New Item," enter a name for your job, select "Multibranch Pipeline," and click "OK."
3. Configure the Source Repository: In the job configuration, under the "Branch Sources" section, add your source code repository (e.g., Git, GitHub, Bitbucket). Provide the necessary repository URL and credentials if required.
4. Define Branch Discovery: Configure branch discovery settings to specify which branches should be included in the pipeline. You can choose to include all branches or filter specific ones.
5. Set Build Triggers: Optionally, configure build triggers to automatically scan the repository for    new branches or changes at regular intervals.
6. Save the Configuration: Click "Save" to create the Multibranch Pipeline job.

# How does Jenkins handle branch-specific configurations in a Multibranch Pipeline?
In a Multibranch Pipeline, Jenkins handles branch-specific configurations by looking for a Jenkinsfile in each branch of the repository. Each branch can have its own Jenkinsfile that defines the pipeline stages, steps, and configurations specific to that branch. When Jenkins scans the repository, it automatically creates a separate pipeline for each branch that contains a Jenkinsfile, allowing for isolated builds and tests per branch. This enables teams to implement different CI/CD workflows for different branches, such as feature branches, development branches, and production branches, without manual configuration.

# What are some best practices for managing Jenkins pipelines using Groovy?
1. Use Declarative Pipelines: Prefer Declarative syntax for better readability and maintainability.
2. Modularize with Shared Libraries: Create reusable functions and classes in Shared Libraries to avoid code duplication.
3. Use Version Control: Store Jenkinsfiles and Shared Libraries in version control systems like Git for tracking changes.
4. Parameterize Pipelines: Use parameters to make pipelines flexible and adaptable to different environments or scenarios.
5. Implement Error Handling: Use try-catch blocks and post conditions to handle errors gracefully.
6. Use Credentials Management: Store sensitive information securely using Jenkins credentials.

# How do you store credntials securely in Jenkins pipelines using Groovy?
Use the withCredentials step to securely access stored credentials in Jenkins pipelines. This ensures that sensitive information like passwords and API keys are not exposed in the pipeline definition or logs.

#  How will you ensure secondary pipelines runs after the secondary pipeline is successful in jenkins using groovy?
You can use the build step to trigger a secondary pipeline after the primary pipeline completes successfully. Here is an example of how to do this in a Jenkins Declarative Pipeline using Groovy:
pipeline {
    agent any
    stages {
        stage('Primary Pipeline') {
            steps {
                echo 'Running primary pipeline...'
                // Primary pipeline logic here
            }
        }
    }
    post {
        success {
            build job: 'Secondary_Pipeline_Job_Name', wait: true
        }
    }
}

In this example, the secondary pipeline (Secondary_Pipeline_Job_Name) will be triggered only if the primary pipeline completes successfully. The wait: true parameter ensures that the primary pipeline waits for the secondary pipeline to finish before proceeding.


choice parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'staging', 'prod'], description: 'Select the deployment environment')
    }
}



# What is the condition to use scripted pipeline over declarative pipeline in jenkins?
Scripted pipelines are preferred over declarative pipelines in Jenkins when you need:
1. Greater flexibility and control over the pipeline logic.
2. Complex workflows that require advanced programming constructs.
3. Dynamic stage creation based on runtime conditions.
4. Integration with external systems or APIs that require custom scripting.
5. Fine-grained error handling and recovery mechanisms.

# How do you implement blue-green deployments using Jenkins pipelines and Groovy?
To implement blue-green deployments using Jenkins pipelines and Groovy, you can follow these steps:
1. Define two environments (blue and green) in your infrastructure.
2. Create a Jenkins pipeline that includes stages for building, testing, and deploying your application.
3. Use environment variables or parameters to specify which environment to deploy to (blue or green).
4. Implement a deployment stage that deploys the application to the specified environment.
5. After deployment, run tests to verify the deployment was successful. 

# How do you clenup temporary file in jenkins workspace?
You can use the cleanWs() step in your Jenkins pipeline to clean up temporary files in the workspace. This step removes all files and directories in the workspace, helping to free up space and ensure a clean environment for subsequent builds.

# Shared Library
Use a Shared Library to avoid duplicating jenkins pipeline code across multiple Java projects or environments.

# Build Failure notifications
1. Install Email extension plugin & Install
2. configure SMTP server
3. In jenkinsfile, In post job add failure block with emailext

# How would you structure a Declarative Pipeline to enforce a clean workspace before every build? 
Add post block, inside it use cleanWs

Use the cleanWs step (from the Workspace Cleanup Plugin) or 
the deleteDir() command in the post or options section: 

pipeline { 
agent any 
options { 
skipDefaultCheckout(true)  // Skip default SCM checkout 
} 
stages { 
        stage('Clean Workspace') { 
            steps { 
                cleanWs()  // Cleans workspace before proceeding 
            } 
        } 
        stage('Build') { 
            steps { sh 'mvn clean install' } 
        } 
    } 
}


✅ Integrate with Slack
Install Slack plugin in jenkins
Create Slack webhook in Slack workspace
Configure Jenkins in Manage Jenkins -> Configure System -> Slack
Add slackSend in pipeline
Use post block for notifications

✅ Integrate with Teams
Create webhook in Teams channel
Use curl or plugin in Jenkins 
Trigger in post block (success/failure)
Use credentials for security'



## Jenkins Blocks
1. agent - where to run the pipeline
2. stages - define stages of the pipeline
3. steps - define steps within a stage
4. post - define actions to take after the pipeline or stage completes
5. environment - define environment variables for the pipeline
6. parameters - define input parameters for the pipeline
7. options - define pipeline-level options (e.g., timeout, retry)
8. retry - retry a block of steps on failure - retry(3)
9. Jenkins store credentials securely - Use the Credentials Binding Plugin or withCredentials in pipelines to avoid exposing secrets in logs. 
 Use the withCredentials block to bind secrets to environment variables:
11. Jenkins RBAC-  Use the Role-Based Authorization Strategy Plugin

12. What steps would you take to harden a Jenkins instance? 
Answer: 
1. Enable HTTPS for the Jenkins dashboard. 
2. Disable legacy protocols (JNLP3) and use JNLP4. (Java Network Launch Protocol agents)
3. Limit plugin installations to trusted sources. 
4. Regularly update Jenkins and plugins. 
5. Use the Matrix Authorization Strategy Plugin to fine-tune permissions. 
6. Set up CSRF protection in "Configure Global Security".

✅ What is JNLP in Jenkins?
JNLP = Java Network Launch Protocol
Used for agent-to-controller communication
Typically used when agents:
Are outside the network
Connect via firewall/NAT
Initiate connection (instead of master connecting)

Q: How do you optimize Jenkins for large-scale deployments?
 Use Jenkins Agents (distribute builds across worker nodes). 
• Implement **Parallel Stages** to speed up builds.
• Leverage **Pipeline Shared Libraries** to reuse code across projects. 
• Configure Jenkins Configuration as Code (JCasC) for scalable, version-controlled 
setups. 

Q.  How do you reduce build times for large monorepo projects?
• Incremental Builds: Use tools like git diff to identify changed modules and build 
only those. 
• Caching: Cache dependencies (e.g., Maven, npm) using Artifactory or Nexus. 
• Parallel Stages: Split tests and builds across parallel agents. 
• Distributed File Systems: Use shared storage (e.g., NFS, S3) for large artifacts.

Static agents are permanently configured nodes in Jenkins that remain available all the time.
A VM or server permanently added to Jenkins:
✔ Pre-configured manually
✔ Always running
✔ Fixed infrastructure
✔ Long-lived machines

Dynamic agents are created on demand when a job runs and destroyed after completion.
✔ Created automatically
✔ Short-lived (ephemeral)
✔ Scalable
✔ Cloud-native

✅ 1. Why is Jenkins called “stateless” but still needs persistence?
Jenkins is conceptually stateless for builds, but it stores state in $JENKINS_HOME:
Job configs
Build history
Plugins
Credentials

✅ 2. What happens if Jenkins Master goes down?
Running builds may fail or stop
Agents may disconnect
Pipelines can be retried if designed properly
✅ Solutions:
High Availability setup
Backup $JENKINS_HOME
Use distributed builds with agents

✅ 4. What is Jenkinsfile and where should it be stored?
A Jenkinsfile defines pipeline as code.
✅ Must be stored: In SCM (Git)

👉 Benefits: Version controlled AND Reproducible builds

✅ 5. How do you achieve zero downtime during deployment in Jenkins?
Jenkins doesn’t do zero downtime itself, but integrates with strategies:
✅ Use:
Rolling deployment
Blue-Green deployment
Canary deployment
👉 Jenkins triggers deployment via pipeline

✅ 6. What are Jenkins Executors?
Executors = parallel build slots on a node
1 executor → 1 job at a time
4 executors → 4 jobs parallel
⚠️ Too many executors = resource contention

✅ 7. How do you handle secret management in Jenkins?
✅ Use:
Jenkins Credentials Store
Vault integration
Environment binding
⚠️ Never hardcode secrets in Jenkinsfile
withCredentials([string(credentialsId: 'token', variable: 'TOKEN')]) {
    sh 'echo $TOKEN'
}

✅ 8. What is the difference between Poll SCM and Webhooks?
Poll SCM: Jenkins periodically checks the repository for changes (e.g., every 5 minutes).
Webhooks: Repository sends an HTTP POST to Jenkins when changes occur, triggering a build immediately.

✅ 9. What is a “Workspace” in Jenkins?
Workspace = directory where job runs
👉 Contains:
Code checkout
Build artifacts

⚠️ Issue:
Workspace conflicts in parallel jobs

✅ Solution:
Use isolated agents or cleanup step


✅ 10. Why do builds fail intermittently in Jenkins?
Common reasons:
Shared workspace issues
Dependency conflicts
Resource starvation (CPU/memory)
Network issues

✅ Fix:
Use clean workspace
Use dynamic agents
Add retry logic

✅ 11. What is Jenkins agent connection failure troubleshooting?
Check:
Network connectivity
JNLP port
Agent logs
Firewall rules
Java version compatibility

✅ Common issue:
👉 JNLP port blocked

✅ 12. How do you scale Jenkins?
✅ Horizontal scaling via:
Adding agents
Kubernetes plugin (dynamic agents)
Cloud agents (EC2)
✅ Avoid scaling master heavily

✅ 13. What is throttling in Jenkins?
Limits number of concurrent builds
✅ Use case:
Prevent DB overload
Control resource usage

✅ 14. How do you manage Jenkins plugins in production?
✅ Best practices:
Avoid unnecessary plugins
Pin plugin versions
Test in staging
Backup before upgrade

✅ 15. Blue-Green deployment vs Canary in Jenkins?
Blue-Green → full switch
Canary → partial traffic
Jenkins just orchestrates these using scripts/tools.

✅ 18. What is “agent any” vs specific agent?
agent any → run on any available node
agent { label 'docker' } → run on specific node

✅ 19. How do you secure Jenkins?
Enable authentication (LDAP/OAuth)
Use Role-based access control
HTTPS (SSL)
Disable anonymous access

✅ 20. Why Jenkins pipeline fails after restart?
Not using Durable Task Plugin
Pipeline not resumable
Agent lost connection

✅ 21. Difference between freestyle job and pipeline?
Freestyle: GUI-based, less flexible, not code-defined
Pipeline: Code-defined (Jenkinsfile), more flexible, supports complex workflows

✅ 22. What are common Jenkins performance issues?
Too many plugins
Large $JENKINS_HOME
Heavy builds on master
Network latency with agents
✅ Fix:
Use agents
Clean workspace
Move builds to agents
Cleanup jobs
Archive artifacts externally

✅ 23. How do you implement parallel stages?
Use parallel block in Declarative Pipeline and add stages

✅ 24. What is the difference between stash and archive?
Stash: Temporary storage for files during a pipeline run, used to share files between stages.
Archive: Permanent storage of build artifacts after a pipeline run, used for long-term access and retrieval.

❓ Why Jenkins is not fully cloud-native?
Stateful (JENKINS_HOME)
Plugin dependency issues
Scaling master is difficult

❓ What is biggest limitation of Jenkins?
Plugin management complexity
Single point of failure (controller)

❓ How do you improve reliability?
Use dynamic agents
Backup Jenkins home
Use monitoring (Prometheus/Grafana)

❓ “Tell me a real issue you solved”
“We faced intermittent build failures in Jenkins due to shared workspace conflicts. I analyzed logs, identified parallel job interference, and migrated to Kubernetes-based dynamic agents with isolated workspaces. This improved build stability and reduced failures by ~80%.”

✅ Strong Closing Answer (if asked “your experience”)
“I’ve worked extensively with Jenkins pipelines using Kubernetes-based dynamic agents, implemented CI/CD with canary and blue-green deployments, handled scaling using cloud agents, and troubleshot production issues like agent disconnections, plugin failures, and performance bottlenecks.”



I have 5+ years of experience managing CI/CD pipelines, AWS infrastructure, and Linux-based Java applications/environments. I’ve worked on automating deployments using PowerShell and Ansible, implementing high-availability architectures, and optimizing cost using auto-scaling and dynamic agents. I also have hands-on experience with Jenkins, GitHub Actions, Prometheus, and Grafana for monitoring and observability.
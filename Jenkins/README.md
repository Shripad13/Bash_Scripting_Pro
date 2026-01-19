
# What is Continuous Integration and Continuous Deployment (CI/CD) in Jenkins?
Continuous Integration (CI) is the practice of automatically building and testing code changes as they are committed to a shared repository. Continuous Deployment (CD) extends this by automatically deploying successful builds to production or staging environments. Jenkins is a popular open-source automation server that facilitates CI/CD by allowing developers to create pipelines that automate the build, test, and deployment processes.

Continuous Deployment - Will be done by Big companies like Netflix, Amazon, Microsoft, MAANG, where every code which is tested & passed will be directly deployed to production without manual intervention.
You should not say continuous deployment in interviews, say continuous delivery.

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
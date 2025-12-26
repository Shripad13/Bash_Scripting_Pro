# Available Tools for Deployments- 

1. Jenkins not really menat for purpose of deployments, Its main goal is CI.
2. Go CD - Its a continuous deployment Tool, Opensource, not widely used.
3. ArgoCD - Its a exclusively for Kubernetes deployments & DONT work for server based deployments.
4. Spinnaker - multi-cloud delivery platform that can handle deployments to various environments, including traditional VMs, cloud services, and serverless platforms. Kubernetes is a popular use case for Spinnaker due to its native integrations and Kubernetes-centric features, but Spinnaker’s flexibility allows it to be used in a wide variety of deployment scenarios.


### CI vs CD vs cd ?
CI - Continuous Integration
CD - Continuous Deployments Vs Continuous Delivery.

  Continuous Delivery is a joke by the way.

Store Plain Text COde stores in Git
Store Binaries Stores in Nexus / Artifactory

Companies will spend millions of dollars on code so they dont want to keep code on git & publish to clients.


# What is Continuous Integration and Continuous Deployment (CI/CD) in Jenkins?
 <Continuous integration (CI) is the practice of automating the integration of code changes from multiple contributors into a single software project. It’s a primary DevOps best practice, allowing developers to frequently merge code changes into a central repository where builds and tests then run.

```
 Popular CI tools include Jenkins, Travis CI, CircleCI, and GitLab CI/CD, GitHub Actions.
 If you use Jenkins , you are responsible for underline platform (OS, Jenkins installation, plugins, etc)
 If you use Github Actions, you are not responsible for underline platform, its a serverless platform. (SaaS model)
 
```

 <Continuous delivery is an extension of continuous integration since it automatically deploys all code changes to a testing and/or production environment after the build stage. 

 <Continuous deployment goes one step further than continuous delivery. With this practice, every change that passes all stages of your production pipeline is released to your customers. There's no human intervention, and only a failed test will prevent a new change to be deployed to production.

Continuous Deployment - Will be done by Big companies like Netflix, Amazon, Microsoft, MAANG, where every code which is tested & passed will be directly deployed to production without manual intervention.
You should not say continuous deployment in interviews, say continuous delivery.

 Jenkins is a popular open-source automation server that facilitates CI/CD by allowing developers to create pipelines that automate the build, test, and deployment processes.

# CI / CD Pipeline Stages -

Github Branch ---> Compile Code ---> Security Checks of Code --> Unit Testing ---> Integration Testing ---> Build Artifacts (Binaries) ---> Version the Package ---> Store Binaries in Nexus/JFrog Artifactory ---> Deploy to Dev/QA/Prod Environments.

Unit/ Integration Testing Code will be developed by Developers. called as Test Driven Development (TDD)
Nexus/JFrog Artifactory - for storing binaries (JAR, WAR, DOCKER IMAGES, TAR FILES, ZIP FILES)
In git we store plain text code only, not binaries.


# OWASP top 10 security vulnerabilities
1. Injection
2. Broken Authentication  
3. Sensitive Data Exposure
4. XML External Entities (XXE)
5. Broken Access Control
6. Security Misconfiguration
7. Cross-Site Scripting (XSS)
8. Insecure Deserialization
9. Using Components with Known Vulnerabilities
10. Insufficient Logging & Monitoring

###
Software Versions- 0.0.1, 0.0.2, 0.03
Purpose of Versioning - To release Adding features, Bug fixes, Security patches, Performance improvements
Versioning Types-  Developer decides the versioning types-
1. Semantic Versioning - MAJOR.MINOR.PATCH
1.1, 1.2, 1.3 - Minor versions
1.0.0, 1.0.1, 1.0.2 - Patch versions
1.0.0, 2.0.0, 3.0.0 - Major versions

'''
Git tag means Alias for a particular commit. git tag means also versioning of the code.
Each git commit does not mean a version.
When you want to release a version, you will create a git tag for that particular commit.

'''






######################### SCRUM FRAMEWOWRK  #########################

## How work is delegated in organizations ?

# Agile Methodology- 
1. Scrum (Active Development Projects)
2. kanban (Support based projects & Work based on unplanned & ticket basis)

Agile Methodology Cycle - PLAN ---> DESIGN ---> DEVELOP ---> TEST ---> DEPLOY ---> REVIEW 


In Scrum , typically form a team of 8 members including Scrum Master & DEV, QA, DEVOPS/SRE

Scrum Master - non-technical  & Responsible for Mangerial Role 

Under Prdoct Manager there will be a 3-4 Scrum Masters 

EPIC is a jira terminology, has a Big Stories (Stories nothing but a tasks)

EPIC ---> Story-01, Story-02, Story-03

1 point : 1/2 day work
3 point : 1-3 days work
5 point : 1 week of work
8 point : 2 weeks of work

Sprint will have 10-15 working days  (2-3 weeks of time)
Everyday will have a scrum call (meeting time is 30 min)
What you did yesterday?, What you are going to do today?, Do you have any blockers?
on the End of the last Sprint Day , need to DEMO on the feature 

Retro call - 
    What went well
    What can be done better
    Areas of improvement
    Kudos 

# What if you are not able to develop the feature/ close the story on time because of
1. Either you are not able to solve it
2. Either you are blocked because of any reason
3. You work towards something & the story was something
4. you have estimated that the task would be of 1 sprint but when you started you've realised that it would need 1 more week.
Then story will be roll over to next spring with valid comments.
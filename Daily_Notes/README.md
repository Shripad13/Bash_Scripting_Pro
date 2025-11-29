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



# Continuous Integration -

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
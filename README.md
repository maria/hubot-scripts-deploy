# Hubot Scripts - Deploy

A script for Hubot which can trigger Continuos Integration tasks, for deploy or test purposes.

What I mean?

## Problem

You have a Jenkins pipeline in place for your deployment system, in other words you deploy your   
application by triggering a Jenkins job in its interface.
You use Slack as your communication tool in your organization, you maybe have the Jenkins  
application installed, so you see when a build starts or ends in a Slack channel.

Cool. But what if you would never have to leave Slack to start&watch a deploy?

You can do that :). I know you know you can, I just want to make our lives easier, by writing the code.


## Solution

You need:
 1. A Jenkins job to deploy your application
 2. A communication tool, let's say Slack
 3. Jenkins integrated with Slack
 4. A Hubot instance (the funny bot from GitHub)


Yes, you can create a Slack command to trigger a Jenkins job, but I think it's easier to   
customize and manage your tasks with these small scripts. Bear with me until the end.

If you're reading this then you should already have 1, 2 & 3 at least. If you don't, you should
start with those: A CI tool, a communication channel and plug them together.

You may also have 4, because Hubot is very useful. From jokes to PagerDuty integrations,  
Hubot is here to make our lives easier.

Using a Hubot command in Slack to test, deploy, build or whatever you want to do, has the following benefits:
- give your team the opportunity to have a backlog of these events in one place: a Slack channel.   
- you will know if someone is deploying the app or if a test suite failed,
- you will be able to parametrized your deploy job for a given git branch,
- you won't have to browse trough dozens of jobs on Jenkins, or to remember which job does what.

Is not useful if Slack is down or Hubot died for any reason, then you should browse trough those jobs  
and find the one you need. Bohooo. :(


## How



### Thank you

I hope you find these scripts useful. If you have a success story, update or a complaint, please create  
an issue and let me know. :)

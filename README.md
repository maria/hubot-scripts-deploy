# Hubot Scripts - Deploy

A script for Hubot which can trigger Continuos Integration tasks, for deploy or test purposes.

What I mean?

## Problem

You have a Jenkins pipeline in place for your deployment system, in other words you  
deploy your application by triggering a Jenkins job in its interface.  

You use Slack as your communication tool in your team, maybe have the Jenkins integration configured,   
so you can see a Jenkins job status inside a Slack channel.  

Cool. What if you would never have to leave Slack to start & monitor a deploy?  
You can do that :).  

(I know you know you can do everything, I just want to make our lives easier by writing the code.)

## Benefits of solving the problem

Using a Hubot command in Slack to test, deploy, build or whatever you want to do, has the following benefits:

- it will give your team the opportunity to have events logs in one place: inside a Slack channel.   
- you will know if someone is deploying the app or if a test suite has failed,
- you will be able to parametrized your deploy job with a given git branch, without having to click twice in Jenkins,
- you won't have to browse trough dozens of jobs on your Jenkins instance, or to remember which job does what.

## Solution ingredients

You need:
 1. A Jenkins/Bamboo (CI tool) job to deploy your application
 2. A communication tool, let's say Slack
 3. A Hubot instance (the funny bot from GitHub)
 4. Nice to have: Jenkins integrated with Slack


Yes, you can create a Slack command to trigger a Jenkins job, but I think it's easier to   
customize and manage your tasks with these scripts.   

If you're reading this then you should already have 1, 2 at least, and maybe 4.   
If you don't, you should start with those: A CI tool, a communication channel and connect them.   

To move forward create a [Hubot]() instance, if you don't already have one.


## Jenkins & Slack use case

```gherkin
Scenario: Deploy the application food-ordering on the development environment from Slack
Given I have an application named *food-ordering*
And I have 3 Jenkins jobs to deploy the application, one for each environment: dev, staging and production
And The Jenkins job name for deploying the app on dev is *DeployFoodOrderingDev*
When I write in Slack: *@hubot deploy food-ordering on dev*
Then the *DeployFoodOrderingDev* job will start.
```

## How

  1. Installation
    - Add to your Hubot repository in `package.json` the `hubot-scripts-deploy` package, or via `npm install hubot-scripts-deploy --save`
    - Enable the script by adding `'hubot-scripts-deploy'` to your  `external-scripts.json` file, in your Hubot project.

  2. Configuration
    - Configure the job in Jenkins to be triggered from a script, use [Build Token Root Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Token+Root+Plugin) for this.  
    - In order to map the appropriate command with its CI job, we have to define a JSON for each script we want to use.  
      Create a JSON file, in a directory wherever on your Hubot server's local storage, with the following format:

    ```json
    {
      "<nameOfYourProject>": {
        "<environment>": {
          "token": "<jenkinsJobToken>",
          "jobName": "<theJenkinsJobName>"
        }
      }
    }
    ```

     For a better understanding & examples, please check [data_example](data_example/) files. The [data_example/jenkins_deploy.json](data_example/jenkins_deploy.json) file  
     describes a mapping between CI jobs and deploy commands, which defined in the [jenkins/deploy.coffee](src/scripts/jenkins/deploy.coffee) script.  

     !*Disclaimer*: The split of the codebase and data for the Jenkins deploy and test commands, it's strictly made for a better scope separation.

    - Create a `config.coffee` file like [config.coffee.example](config.coffee.example) and add the needed settings like:
      - *JENKINS_URL* - the URL of your Jenkins master instance, with port and user & password (if set). Keep in mind that the URL must be    
        accessible from the server on which you run your Hubot instance.
      - *JENKINS_DEPLOY_DATA_FILE_PATH* - the absolute path to the JSON file created for the mapping of the deploy commands.
      - *JENKINS_TEST_DATA_FILE_PATH* - the absolute path to the JSON file created for the mapping of the test commands.

  3. Run
    - Run your Hubot instance by setting the environment variable `HUBOT_DEPLOY_CONFIG_PATH` to match the absolute path to your `config.coffee` file.


### Thank you

I hope you find these scripts useful. If you have a success story, update or a complaint,   
please create an issue and let me know. :)

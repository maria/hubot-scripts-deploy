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

  1. Installation

    - Add to your Hubot repository in `package.json` the `hubot-scripts-deploy` package, or via `npm install hubot-scripts-deploy --save`
    - Enable the script by adding `'hubot-scripts-deploy'` to your  `external-scripts.json` file, in your Hubot repository.

  2. Configuration
    - In order to map the appropriate command with its job, we have to define a JSON for each script.

      - Let's say you have an application which it's GitHub repo name is `food-ordering`, and you have 3 Jenkins jobs to deploy the application,  
each for the environment you have: dev, staging and production.    
      - To be able to run a specific job by typing a command in Slack, you have to first configure the job in Jenkins to be triggered from a script,  
 use [Build Token Root Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Build+Token+Root+Plugin) for this. Let's say you generate & set the token: `12345`.  
      - The job name in Jenkins is *DeployFoodOrderingDev*, its name is visible in the URL of the job homepage or configuration.
      - I want to write in Slack: `@hubot deploy food-ordering on dev` a.k.a **I want to deploy the application *food-ordering* on the development environment**.  

    Now we will glue all together. Create a file, in a `data` directory in your home directory, named `jenkins_deploy.json` with the following content:

      ```json
      {
        "food-ordering": {
          "dev": {
            "token": "12345",
            "jobName": "DeployFoodOrderingDev"
          }
        }
      }
      ```


    In other words, to be able to map a given command in Slack with a specific Jenkins job, we have to create a dictionary with the following format:

    ```json
    {
      "<nameOfYourProject>": {
        "<environment>": {
          "token": "<aRandomToken>",
          "jobName": "<theJenkinsJobName>"
        }
      }
    }
    ```

    For a better understanding please check [data_example](data_example/) directory files.

  - Create a `config.coffee` file like [config.coffee.example](config.coffee.example) and add the needed settings like:
    - *JENKINS_URL* - the URL of your Jenkins master instance, with port and if needed user & password. Keep in mind that the URL must be   
    accessible from the server  where you run your Hubot instance.
    - *JENKINS_DEPLOY_DATA_FILE_PATH* - the path to the JSON file created for the mapping of the deploy commands.

  3. Run
    - Run your Hubot instance by setting the environment variable `HUBOT_DEPLOY_CONFIG_PATH` to match the path to your `config.coffee` file.


### Thank you

I hope you find these scripts useful. If you have a success story, update or a complaint, please create  
an issue and let me know. :)

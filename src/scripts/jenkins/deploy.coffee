# Description:
#   Command to trigger a deploy job via Jenkins
#   A deploy job is a regular Jenkins job, which has the scope to deploy a project
#
# Commands:
#   hubot deploy <repo> on <environment> [from <branch>] - Deploy the application on a certain environment. If a branch is specified and the job is parametrized, then it will set the branch.

cson = require('cson')
jenkins = require('../../jenkins')

# Load a json file which describes the correlation between command's keywords and Jenkins job configuration
config = require(process.env.HUBOT_DEPLOY_CONFIG_PATH)
jenkinsDeployToken = require(process.env.JENKINS_DEPLOY_TOKEN)
JENKINS_DEPLOY_DATA = cson.parseJSONFile(config.JENKINS_DEPLOY_DATA_FILE_PATH)

module.exports = (robot) ->

  robot.respond /deploy (.*) on (\w+)$/i, (msg) ->
    # Trigger a job only with a given repo and environment
    appRepo = msg.match[1]
    appEnv = msg.match[2]

    jenkinsJob = JENKINS_DEPLOY_DATA[appRepo][appEnv]["jobName"]

    jenkins.notifyJenkins jenkinsDeployToken, jenkinsJob, null, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start deploy of #{appRepo} on #{appEnv}."

  robot.respond /deploy (.*) on (\w+) from ([\w-\/\#]+)$/i, (msg) ->
    # Trigger a job for a given repo and environment, specifying the "branch" parameter
    # The Jenkins job has to be configured beforehand to be able to receive a parameter, named "branch"
    appRepo = msg.match[1]
    appEnv = msg.match[2]
    appBranch = msg.match[3]

    jenkinsJob = JENKINS_DEPLOY_DATA[appRepo][appEnv]["jobName"]

    jenkins.notifyJenkins jenkinsDeployToken, jenkinsJob, appBranch, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start deploy of #{appRepo} on #{appEnv} from #{appBranch}."

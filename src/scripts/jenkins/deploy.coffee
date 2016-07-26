# Description:
#   Command to trigger a deploy job via Jenkins
#   A deploy job is a regular Jenkins job, which has the scope to deploy a project
#
# Commands:
#   KUBOT deploy <repo> on <environment> [from <branch>] - Deploy the application on a certain environment. If a branch is specified and the job is parametrized, then it will set the branch.

requestify = require('requestify')
cson = require('cson')

notifyJenkins = require('../main').notifyJenkins

# Load a json file which describes the correlation between command's keywords and Jenkins job configuration
config = require(process.env.CONFIG_PATH)
JENKINS_DEPLOY_DATA = cson.parseJSONFile(config.JENKINS_DEPLOY_DATA_FILE_PATH)

module.exports = (robot) ->

  robot.respond /deploy (.*) on (\w+)$/i, (msg) ->
    # Trigger a job only with a given repo and environment
    appRepo = msg.match[1]
    appEnv = msg.match[2]

    jenkinsToken = JENKINS_CONFIG[appRepo][appEnv]["token"]
    jenkinsJob = JENKINS_CONFIG[appRepo][appEnv]["jobName"]

    notifyJenkins jenkinsToken, jenkinsJob, null, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start deploy of #{appRepo} on #{appEnv}."

  robot.respond /deploy (.*) on (\w+) from ([\w-\/\#]+)$/i, (msg) ->
    # Trigger a job for a given repo and environment, specifying the "branch" parameter
    # The Jenkins job has to be configured beforehand to be able to receive a parameter, named "branch"
    appRepo = msg.match[1]
    appEnv = msg.match[2]
    appBranch = msg.match[3]

    jenkinsToken = JENKINS_CONFIG[appRepo][appEnv]["token"]
    jenkinsJob = JENKINS_CONFIG[appRepo][appEnv]["jobName"]

    notifyJenkins jenkinsToken, jenkinsJob, appBranch, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start deploy of #{appRepo} on #{appEnv} from #{appBranch}."

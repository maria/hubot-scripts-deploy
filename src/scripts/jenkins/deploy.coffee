# Description:
#   Command to trigger a deploy job via Jenkins
#
# Commands:
#   KUBOT deploy <repo> on <environment> [from <branch>] - Deploy the application on a certain environment. If a branch is specified and the job is parametrized, then it will set the branch.

requestify = require('requestify')
cson = require('cson')

notifyJenkins = require('../main').notifyJenkins

config = require(process.env.CONFIG_PATH)
JENKINS_CONFIG = cson.parseJSONFile(config.JENKINS_DATA_DEPLOY)

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
    appRepo = msg.match[1]
    appEnv = msg.match[2]
    appBranch = msg.match[3]

    jenkinsToken = JENKINS_CONFIG[appRepo][appEnv]["token"]
    jenkinsJob = JENKINS_CONFIG[appRepo][appEnv]["jobName"]

    notifyJenkins jenkinsToken, jenkinsJob, appBranch, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start deploy of #{appRepo} on #{appEnv} from #{appBranch}."

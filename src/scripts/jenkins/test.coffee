# Description:
#   Command to trigger a test job via Jenkins
#
# Commands:
#   KUBOT test <repo> on <environment> [from <branch>] - Test the application on a certain environment. If a branch is specified and the job is parametrized, then it will set the branch.

requestify = require("requestify")

notifyJenkins = require('../main').notifyJenkins

config = require(process.env.CONFIG_PATH)
JENKINS_CONFIG = cson.parseJSONFile(config.JENKINS_DATA_TEST)

module.exports = (robot) ->

  robot.respond /test (.*) on (\w+)$/i, (msg) ->
    appRepo = msg.match[1]
    appEnv = msg.match[2]

    jenkinsToken = JENKINS_CONFIG[appRepo][appEnv]["token"]
    jenkinsJob = JENKINS_CONFIG[appRepo][appEnv]["jobName"]

    notifyJenkins jenkinsToken, jenkinsJob, null, null, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start testing of #{appRepo} on #{appEnv}."

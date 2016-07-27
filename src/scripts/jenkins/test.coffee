# Description:
#   Command to trigger a test job via Jenkins
#   A test job is a regular Jenkins job, which has the scope to run test suite for a given project
#
# Commands:
#   hubot test <repo> on <environment> [from <branch>] - Test the application on a certain environment. If a branch is specified and the job is parametrized, then it will set the branch.

cson = require('cson')
jenkins = require('../../jenkins')

# Load a json file which describes the correlation between command's keywords and Jenkins job configuration
config = require(process.env.HUBOT_DEPLOY_CONFIG_PATH)
JENKINS_TEST_DATA = cson.parseJSONFile(config.JENKINS_TEST_DATA_FILE_PATH)

module.exports = (robot) ->

  robot.respond /test (.*) on (\w+)$/i, (msg) ->
    # Trigger a job only with a given repo and environment
    appRepo = msg.match[1]
    appEnv = msg.match[2]

    jenkinsToken = JENKINS_TEST_DATA[appRepo][appEnv]["token"]
    jenkinsJob = JENKINS_TEST_DATA[appRepo][appEnv]["jobName"]

    jenkins.notifyJenkins jenkinsToken, jenkinsJob, null, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start testing of #{appRepo} on #{appEnv}."

  robot.respond /test (.*) on (\w+) from ([\w-\/\#]+)$/i, (msg) ->
    # Trigger a job for a given repo and environment, specifying the "branch" parameter
    # The Jenkins job has to be configured beforehand to be able to receive a parameter, named "branch"
    appRepo = msg.match[1]
    appEnv = msg.match[2]
    appBranch = msg.match[3]

    jenkinsToken = JENKINS_TEST_DATA[appRepo][appEnv]["token"]
    jenkinsJob = JENKINS_TEST_DATA[appRepo][appEnv]["jobName"]

    jenkins.notifyJenkins jenkinsToken, jenkinsJob, appBranch, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start testing of #{appRepo} on #{appEnv} from #{appBranch}."

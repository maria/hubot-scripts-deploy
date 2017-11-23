# Description:
#   Command to trigger a CI or CD Pipeline via Jenkins
#
# Commands:
#   hubot (ci|cd) <pipeline-name> on <environment> [ with branch=<branch> ...] -
#
#      Deploy or test the application on a certain environment, specified in then
# configuration file.
# Specify a list of options separated by space, starting from `with` which will
#  be sent as build parameters, where the key is the parameter name accepted by
# the job configuration and the key is the value, hence `with branch=staging`
# will set the parameter `branch` as being `staging`.

cson = require('cson')
utils = require('../../utils')

# Load a json file which describes the correlation between command's keywords
# and Jenkins job configuration
jenkinsDeployToken = process.env.JENKINS_DEPLOY_TOKEN
jenkinsDeployData =  cson.parseJSONFile("#{process.env.JENKINS_DEPLOY_DATA_FILE_PATH}")

module.exports = (robot) ->

  robot.respond /(cd|ci) (.*) on (\w+)$/i, (msg) ->
    # Trigger a job only with a given repo and environment
    appRepo = msg.match[1]
    appEnv = msg.match[2]

    jenkinsJob = jenkinsDeployData[appRepo][appEnv]["jobName"]

    utils.notifyJenkins jenkinsDeployToken, jenkinsJob, {}, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start deploy of #{appRepo} on #{appEnv}."

  robot.respond /(cd|ci) (.*) on (\w+) with ([\w-_=\/\\\# ]+)$/i, (msg) ->
    # Trigger a job for a given repo and environment, specifying a list of params
    # The Jenkins job has to be configured beforehand to be able to receive
    # parameters, named as they keys set in the command.
    appRepo = msg.match[1]
    appEnv = msg.match[2]
    buildParams = utils.jsonBuildParams(msg.match[3])

    jenkinsJob = jenkinsDeployData[appRepo][appEnv]["jobName"]

    utils.notifyJenkins jenkinsDeployToken, jenkinsJob, buildParams, (what) ->
      console.log(what)

    msg.send "I notified Jenkins to start deploy of #{appRepo}on #{appEnv} with build params."

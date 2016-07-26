config = require(process.env.HUBOT_DEPLOY_CONFIG_PATH)

JENKINS_URL = config.JENKINS_URL

module.exports =

  notifyJenkins: (jenkinsToken, jenkinsJob, jenkinsBranch, cb) ->
    baseUrl = "#{JENKINS_URL}/job/#{jenkinsJob}"

    if appBranch
      url = baseUrl + "/buildWithParameters?token=#{jenkinsToken}&branch=#{jenkinsBranch}"
    else
      url = baseUrl + "/build?token=#{jenkinsToken}"

    requestify.post(url, {})
    console.log("Request sent to #{url}.")

config = require(process.env.CONFIG_PATH)

JENKINS_URL = config.JENKINS_URL

module.exports =

  notifyJenkins: (jenkinsToken, jenkinsJob, jenkinsBranch, jenkinsEnvironment, cb) ->
    baseUrl = "#{JENKINS_URL}/job/#{jenkinsJob}"

    if appEnv && appBranch
      url = baseUrl + "/buildWithParameters?token=#{jenkinsToken}&branch=#{jenkinsBranch}&app_environment=#{jenkinsEnvironment}"
    if appBranch
      url = baseUrl + "/buildWithParameters?token=#{jenkinsToken}&branch=#{jenkinsBranch}"
    else
      url = baseUrl + "/build?token=#{jenkinsToken}"

    requestify.post(url, {})
    console.log("Request sent to #{url}.")

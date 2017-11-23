requestify = require('requestify')

JENKINS_URL = process.env.JENKINS_URL

module.exports =

  notifyJenkins: (jenkinsToken, jenkinsJob, jenkinsBranch, cb) ->
    baseUrl = "#{JENKINS_URL}/job/#{jenkinsJob}"

    if jenkinsBranch
      url = baseUrl + "/buildWithParameters?token=#{jenkinsToken}&branch=#{jenkinsBranch}"
    else
      url = baseUrl + "/build?token=#{jenkinsToken}"

    requestify.post(url, {})
    console.log("Request sent to #{url}.")

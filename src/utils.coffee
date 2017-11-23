requestify = require('requestify')

JENKINS_URL = process.env.JENKINS_URL

module.exports =

  notifyJenkins: (jenkinsToken, jenkinsJob, jenkinsParams, cb) ->
    baseUrl = "#{JENKINS_URL}/job/#{jenkinsJob}/build?token=#{jenkinsToken}"
    requestify.post(url, data)
    console.log("Request sent to #{url}.")

  jsonBuildParams: (buildParams) ->
    jsonParams = {}
    jsonParams["#{param.split('=')[0]}"] = "#{param.split('=')[1]}" for param in buildParams.split(' ')
    return jsonParams

requestify = require('requestify')

JENKINS_URL = process.env.JENKINS_URL

module.exports =

  notifyJenkins: (jenkinsToken, jenkinsJob, jenkinsParams, cb) ->
    url = "#{JENKINS_URL}/job/#{jenkinsJob}/build?token=#{jenkinsToken}"

    response = requestify.post(url, data)
    console.log("Request sent to #{url}.")
    return response

  jsonBuildParams: (buildParams) ->
    # Transform a list of strings [key1=value1, key2=valu2, ...] to a dictionary
    jsonParams = {}
    jsonParams["#{param.split('=')[0]}"] = "#{param.split('=')[1]}" for param in buildParams.split(' ')
    return jsonParams

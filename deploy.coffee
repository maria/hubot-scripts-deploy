fs = require 'fs'
path = require 'path'

module.exports = (robot, scripts) ->
  scriptsPath = path.resolve(__dirname, 'src', 'scripts')
  fs.exists scriptsPath, (exists) ->
    if exists
      console.log "Scripts directory path is: #{scriptsPath}"

      for scriptModule in fs.readdirSync(scriptsPath)
        scriptModulePath = path.resolve(__dirname, 'src', 'scripts', "#{scriptModule}")
        fs.stat scriptModulePath, (error, pathStats) ->

          if pathStats.isDirectory()
            console.log "Load each script of #{scriptModulePath} module..."
            for script in fs.readdirSync(scriptModulePath)
              robot.loadFile(scriptModulePath, script)
              console.log "The script #{script} has been loaded from the module #{scriptModule}."

          else if pathStats.isFile()
              console.log "Load standalone script..."
              robot.loadFile(scriptPath, scriptModule)
              console.log "The script #{script} has been loaded."

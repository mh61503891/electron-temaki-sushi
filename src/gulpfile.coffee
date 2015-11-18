path = require('path')
fs = require('fs-extra')
tmp = require('tmp')
ect = require('ect')
meow = require('meow')
packager = require('electron-packager')
CoffeeScript = require('coffee-script')
os = require('os')
sync = require('synchronize')
cheerio = require('cheerio-httpcli')
gulp = require('gulp')

gulp.task 'default', ->
  cli = meow()
  console.error "Fetching #{cli.input[0]} to get the title"
  cheerio.fetch cli.input[0], (err, $, res, body) ->
    params = {
      url: cli.input[0]
      title: $('title').text()
    }
    # reinder
    renderer = ect(root: path.join(__dirname, '../', 'templates'))
    pkg = {
      name: params.title
      version: '0.0.1',
      main: 'main.js'
    }
    packageJSON = JSON.stringify(pkg, null, '  ')
    mainJS = CoffeeScript.compile(renderer.render('main.coffee'))
    indexHTML = renderer.render('index.html', params)
    indexJS = CoffeeScript.compile(renderer.render('index.coffee'))

    tmp.setGracefulCleanup()
    tmp.dir (error, tmpdir, cleanup) ->
      console.error "Runing mkdir #{tmpdir}"
      throw error if error
      # write
      srcPath = path.join(tmpdir, 'src')
      console.error "Generating the template files into #{srcPath}"
      fs.mkdirSync(srcPath)
      fs.writeFileSync(path.join(srcPath, 'package.json'), packageJSON)
      fs.writeFileSync(path.join(srcPath, 'main.js'), mainJS)
      fs.writeFileSync(path.join(srcPath, 'index.html'), indexHTML)
      fs.writeFileSync(path.join(srcPath, 'index.js'), indexJS)
      # pack
      opts = {
        dir: srcPath
        name: params.title
        version: '0.35.0'
        platform: os.platform()
        arch: os.arch()
        overwrite: true
      }
      packager opts, (error, appPaths) ->
        throw error if error
        for appPath in appPaths
          console.error "App: #{appPath}"

module.exports = gulp

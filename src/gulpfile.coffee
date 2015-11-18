path = require('path')
fs = require('fs')
tmp = require('tmp')
ect = require('ect')
meow = require('meow')
packager = require('electron-packager')
CoffeeScript = require('coffee-script')
os = require('os')
gulp = require('gulp')
url = require('url')
process = require('process')

gulp.task 'default', ->
  cli = meow()
  params = {
    title: cli.input[0]
    url: cli.input[1]
  }
  try
    url.parse(params.url)
  catch e
    console.error e.message
    process.exit(1)

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
    console.error "Generating the template files into #{tmpdir}"
    fs.writeFileSync(path.join(tmpdir, 'package.json'), packageJSON)
    fs.writeFileSync(path.join(tmpdir, 'main.js'), mainJS)
    fs.writeFileSync(path.join(tmpdir, 'index.html'), indexHTML)
    fs.writeFileSync(path.join(tmpdir, 'index.js'), indexJS)
    # pack
    opts = {
      dir: tmpdir
      name: params.title
      version: '0.35.0'
      platform: os.platform()
      arch: os.arch()
      overwrite: true
    }
    console.log opts
    packager opts, (error, appPaths) ->
      throw error if error
      for appPath in appPaths
        console.error "App: #{appPath}"

module.exports = gulp

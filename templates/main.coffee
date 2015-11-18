app = require('app')
BrowserWindow = require('browser-window')
Menu = require("menu")
require('crash-reporter').start()

mainWindow = null

app.on 'window-all-closed', ->
  app.quit()

app.on 'ready', ->
  mainWindow = new BrowserWindow {
    width: 1000
    height: 600
  }
  mainWindow.loadUrl('file://' + __dirname + '/index.html')
  # mainWindow.openDevTools()
  mainWindow.on 'closed', ->
    mainWindow = null

  template = [
    {
      label: 'Application'
      submenu: [
        {
          label: 'About Application'
          selector: 'orderFrontStandardAboutPanel:'
        }
        { type: 'separator' }
        {
          label: 'Quit'
          accelerator: 'Command+Q'
          click: ->
            app.quit()
            return
        }
      ]
    }
    {
      label: 'Edit'
      submenu: [
        {
          label: 'Undo'
          accelerator: 'CmdOrCtrl+Z'
          selector: 'undo:'
        }
        {
          label: 'Redo'
          accelerator: 'Shift+CmdOrCtrl+Z'
          selector: 'redo:'
        }
        { type: 'separator' }
        {
          label: 'Cut'
          accelerator: 'CmdOrCtrl+X'
          selector: 'cut:'
        }
        {
          label: 'Copy'
          accelerator: 'CmdOrCtrl+C'
          selector: 'copy:'
        }
        {
          label: 'Paste'
          accelerator: 'CmdOrCtrl+V'
          selector: 'paste:'
        }
        {
          label: 'Select All'
          accelerator: 'CmdOrCtrl+A'
          selector: 'selectAll:'
        }
      ]
    }
  ]
  Menu.setApplicationMenu Menu.buildFromTemplate(template)

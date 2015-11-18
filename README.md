# electron-temaki-sushi (エレクトロン手巻き寿司)

This is a command line tool to generate Electron Application from specified URL.

1. 🙋 < `electron-temaki-sushi Electron http://electron.atom.io/`
2. 🙆 🍣(Electron.app)三👏😊

## Install

```bash
npm install electron-temaki-sushi -g
```

## Usage

```bash
electron-temaki-sushi <AppName> <URL>
```

## Example

Install:

```bash
$ npm install electron-temaki-sushi -g
```

Run:

```bash
$ electron-temaki-sushi Electron http://electron.atom.io/
Fetching http://electron.atom.io/ to get the title
Runing mkdir /var/folders/cc/470s1lj92dx_7z9ykv36kt0m0000gn/T/tmp-73332nNcFKchDwSq
Generating the template files into /var/folders/cc/470s1lj92dx_7z9ykv36kt0m0000gn/T/tmp-73332nNcFKchDwSq/src
Packaging app for platform darwin x64 using electron v0.35.0
App: /Users/sushi/Electron-darwin-x64
```

App:

```bash
$ /bin/ls -1 /Users/sushi/Electron-darwin-x64
Electron.app <= 🍣
LICENSE
LICENSES.chromium.html
version
```

## Author

Masayuki Higashino

## License

The MIT License

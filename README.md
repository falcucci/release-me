# Release-me 

## What is it? :bulb:

It's just useful scripts to make our work when we talk about changelogs, releases and build automation like `APK's` generation and send it into `google drive'`s folders. It also could be a `gist` but obviously I want to put other scripts related of it as I need here.

# Requirements

## Config to use `react-native-release.sh` script

Before to start to use it, please install the following dependencies:

* [ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [GitHub Changelog Generator](https://github.com/github-changelog-generator/github-changelog-generator)
* [chandler](https://github.com/mattbrictson/chandler)
* [npm](https://github.com/creationix/nvm)
* React Native Version `npm install -g react-native-version`

Basically it uses the libraries above to make the automation and currently could be executed from your `terminal` by the following snippet: 
```shell
bash -c "$(curl -LsS https://raw.githubusercontent.com/falcucci/release-me/master/react-native-release.sh)"
```
or just put it on your `package.json` as follows:

```json
{
  "scripts": {
    "publish": "curl -LsS https://raw.githubusercontent.com/falcucci/release-me/master/react-native-release.sh | bash -s"
  }
}
```

## Config to use `apk-builder.sh` script

Before to start to use it, please install the following dependencies:

* [gdrive](https://github.com/prasmussen/gdrive)

The script will build your `APK` file and send it for you google drive folder to manage your versions. For now you could add a npm script at your `package.json` as follows:
```json
{
  "scripts": {
    "build": "curl -LsS https://raw.githubusercontent.com/falcucci/release-me/master/apk-builder.sh | bash -s",
  }
}
```

Also, read how [gdrive](https://github.com/prasmussen/gdrive) works and add the `GOOGLE_DRIVE_FOLDER_ID` variable in your `.env.<environment>` file as your google drive folder identifier. If you have two folder, put each one in the related `.env`.

That's it! :sparkles:

## License

The code is available under the [MIT license](LICENSE).

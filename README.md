# Release-me 

### What is it? :bulb:

It's just useful scripts to make our work when we talk about changelogs, releases and build automation like `APK's` generation and sending it into `google drive'`s folders. It also could be a `gist` but obviously I want put other scripts related of it as I need here.

## Requirements 

Before to start to use it, please install the following dependencies:

* [ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [GitHub Changelog Generator](https://github.com/github-changelog-generator/github-changelog-generator)
* [chandler](https://github.com/mattbrictson/chandler)
* [npm](https://github.com/creationix/nvm)
* React Native Version `npm install -g react-native-version`



## react-native script

Basically it uses the libraries above to make the automation and currently could be executed from your `terminal` by the following snippet: 
```shell
bash -c "$(curl -LsS https://raw.githubusercontent.com/falcucci/release-me/master/react-native-release.sh)"
```
or just put it on your `package.json` as follows:

```json
{
  "publish": "curl -LsS https://raw.githubusercontent.com/falcucci/release-me/master/react-native-release.sh | bash -s"
}
```

That's it! :sparkles:

## License

The code is available under the [MIT license](LICENSE).

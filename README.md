Release-me it's just useful scripts to make our work when we talk about changelogs, releases and build automation. Currently we can execute the script from or `terminal` with `bash -c "$(curl -LsS https://raw.githubusercontent.com/falcucci/release-me/master/react-native-release.sh)"` or your could put it on your `package.json` as follows:
```json
{
  "publish": "curl -LsS https://raw.githubusercontent.com/falcucci/release-me/master/react-native-release.sh | bash -s"`
}
```


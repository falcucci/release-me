### Release-me 

It's just useful scripts to make our work when we talk about changelogs, releases and build automation. It also could be a `gist` obviously but I want put other scripts related of it as I need.

Basically it uses some libraries to make the automation and currently could be executed from your `terminal` by the following snippet: 
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

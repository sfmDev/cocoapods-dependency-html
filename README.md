# cocoapods-dependency-html

[![Build Status](https://travis-ci.org/sfmdev/cocoapods-dependency-html.svg?branch=master)](https://travis-ci.org/sfmdev/cocoapods-dependency-html)
[![Coverage Status](https://coveralls.io/repos/github/sfmdev/cocoapods-dependency-html/badge.svg?branch=master)](https://coveralls.io/github/sfmdev/cocoapods-dependency-html?branch=master)
[![Gem Version](https://badge.fury.io/rb/cocoapods-dependency-html.svg)](https://badge.fury.io/rb/cocoapods-dependency-html)


A CocoaPods plugin which can show the dependencies of a project manager by Cocoapods.

## Installation

    $ gem install cocoapods-dependency-html
## Config Setting
Ths plugin need to new a file named `dependency_config` in project root  path.</br>
The file named `dependency_config` is a json file, the key is level name, the value is a regular Expression.
Here is an example file.
```json
{
	"first": "^LPD.*?Module",
	"second": "^LPD",
	"third": "\\||^ELM|^APF|^TB|^Ali"
}
```
## Usage
```shell
# show the dependency with levels in config file.
$ pod dependency

# show tree to show every level dependency.
$ pod dependency --use-tree
```
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

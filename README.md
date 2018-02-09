# SysLibDetector

SysLibDetector helps in solving an irritating issue, which is ruby gems requiring native system dependencies, such as 'nokogiri' gem, as if you don't know upfront that you need to install ‘zlib1g-dev’ and ‘liblzma-dev’ you will be hit with an exception about a missing system library, and you won't be able to know this till checking Nokogiri's website.

## How SysLibDetector works

SysLibDetector collects your project's local gems and your system's operating system information and make an API request with this information to a web-service https://sys-libraries.herokuapp.com, which retrieves the **possibly found** system native libraries required for correct installation and usage of your project's gems.

## Dependencies

* [Json](https://rubygems.org/gems/json): for parsing json responses from the web-service.
* [System](https://rubygems.org/gems/system): for system's operating system detection
* [Thor](https://rubygems.org/gems/thor): for building a command-line interface.
* [RestClient](https://rubygems.org/gems/rest-client): a rest client for the web-service communication

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sys_lib_detector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sys_lib_detector

## Usage

* Show the available methods

      $ sys-lib-detector help 

* List your project's gems

      $ sys-lib-detector list_all_gems

* List the **available** required system libraries for your project's gems

      $ sys-lib-detector list_sys_libs

	*Note: The web-service is continuously updated with gem's system libraries dependencies upon the contribution of different contributors, and you among those! Check the contribution part below.

* Install the **available** required system libraries for your project's gems

      $ sys-lib-detector install_sys_libs

	*Note: Supported operating systems are Linux and OS X, with package managers `APT` and `Homebrew` respectively.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

### Adding new gem's system libraries

You can contribute yourself in order for making the whole process more reliable and more useful by adding gems' system dependencies.

This can be done by making a simple POST API request to the web-service (contributing endpoint) https://sys-libraries.herokuapp.com/contribute_requests including your email, gem's information (name and version) and the system libraries dependencies, as in this example
```
{
	"email": "you@example.com",
	"ruby_gem": {
		"name": "nokogiri",
		"version": "1.8.2"
	},
	"libraries": [
		{
			"platform": "linux",
			"name": "zlib1g-dev"
		},
        	{
			"platform": "linux",
			"name": "liblzma-dev"
		},
		{
			"platform": "osx",
			"name": "libxml2"
		}
	]
}
```
***NOTE:** You can leave `version` field in `ruby_gems` attributes empty

***NOTE:** `platform` field in `libraries` attributes can be any of those: 'linux', 'osx' or 'windows'

### SysLibDetector gem
Bug reports and pull requests are welcome on GitHub at https://github.com/HusseinReda/sys_lib_detector.
The project is always welcoming for contributions.

## Future Plans

* Adding Windows to supported operating systems.
* Automating the manual review of the contribution requests of adding gems' dependencies.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

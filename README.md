# PDI

---

[![Gem Version](https://badge.fury.io/rb/pdi.svg)](https://badge.fury.io/rb/pdi) [![Build Status](https://travis-ci.org/bluemarblepayroll/pdi.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/pdi) [![Maintainability](https://api.codeclimate.com/v1/badges/955e491a34465360bf64/maintainability)](https://codeclimate.com/github/bluemarblepayroll/pdi/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/955e491a34465360bf64/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/pdi/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

*Note: This is not officially supported by Hitachi Vantara.*

This library provides a Ruby wrapper around [Pentaho Data Integration](https://www.hitachivantara.com/en-us/products/data-management-analytics/pentaho-platform/pentaho-data-integration.html) that allows you to execute tranformations and jobs via command line.

## Installation

To install through Rubygems:

````bash
gem install pdi
````

You can also add this to your Gemfile:

````bash
bundle add pdi
````

## Compatibility

This library was tested against:

* Kettle version 6.1.0.1-196
* MacOS and Linux

Pull Requests are welcome for:

* Windows support
* Upgraded Kettle versions (while maintaining backwards compatibility)

## Examples

All examples assume PDI has been installed to your home directory: `~/data-integration`.

### Creating a Spoon Instance

`Pdi::Spoon` is the common interface you will use when interacting with PDI.  It will use Pan and Kitchen for executing Spoon commands.

```ruby
spoon = Pdi::Spoon.new(dir: '~/data-integration')
```

Note: You can also override the names of the scripts using the `kitchen` and `pan` constructor keyword arguments.  The defaults are `kitchen.sh` and `pan.sh`, respectively.

### Executing a Job/Transformation

```ruby
options = {
  level: Pdi::Spoon::Level::DETAILED,
  name: 'update_address',
  repository: 'transformations/demographics',
  params: {
    file: 'addresses.csv'
  },
  type: :transformation
}

result = spoon.run(options)
```

`Spoon#run` will return:

* `Pdi::Spoon::Result` upon a successful run.
* If a non-zero exit code was returned then a `Pdi::Spoon::PanError` or `Pdi::Spoon::KitchenError` will be raised.

You can access the raw command line results by tapping into the execution attribute of the result or error object.

Note: Not all options are currently supported.  See PDI's official references for [Pan](https://help.pentaho.com/Documentation/6.1/0L0/0Y0/070/000) and [Kitchen](https://help.pentaho.com/Documentation/6.1/0L0/0Y0/070/010) to see all options.

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check pdi.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/pdi.git)
4. Navigate to the root folder (cd pdi)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite and code-coverage tool, run:

````bash
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````bash
bundle exec guard
````

Also, do not forget to run Rubocop:

````bash
bundle exec rubocop
````

or run all three in one command:

````bash
bundle exec rake
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update `lib/pdi/version.rb` using [semantic versioning](https://semver.org/)
3. Install dependencies: `bundle`
4. Update `CHANGELOG.md` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Code of Conduct

Everyone interacting in this codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bluemarblepayroll/pdi/blob/master/CODE_OF_CONDUCT.md).

## License

This project is MIT Licensed.

# Ossy

Ossy is a CLI tool that provides various commands that help with maintenance automation.

## Status

This is an early stage, things are changing fast. Currently `ossy` is used by [dry-rb.org](https://dry-rb.org) and [rom-rb.org](https://rom-rb.org).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ossy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ossy

## Usage

First of all you need two `ENV` variables:

- `GITHUB_LOGIN` - the username that ossy will use to talk to GitHub
- `GITHUB_TOKEN` - the personal access token that you can create under [Developer settings](https://github.com/settings/tokens) on GitHub

Then, to learn more, type this in your terminal:

```bash
ossy help
```

Here are some `github` examples:

```bash
$ ossy github tagger dry-rb/dry-validation v1.2.0
Piotr Solnica

$ ossy github membership solnic dry-rb core
solnic has active membership in dry-rb/@core

$ ossy github workflow dry-rb/dry-validation sync_configs
Requesting: dry-rb/dry-validation => sync_configs
Success!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/solnic/ossy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ossy project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/solnic/ossy/blob/master/CODE_OF_CONDUCT.md).

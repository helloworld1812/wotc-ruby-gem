![WOTC_logo_header-02](https://user-images.githubusercontent.com/1224077/79107910-d97bc880-7da7-11ea-95a3-40be03be614c.png)

# wotc-ruby-gem

Ruby toolkit for wotc.com API

## quick start

Add this line to your application's Gemfile:

```ruby
gem 'wotc-ruby-gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wotc-ruby-gem

## Making request

```
# Provide authentication credential
# How to get access token?
# https://sandbox.wotc.com/portal/client/account/integrations#show-access-token
 
client = WOTC::Client.new(access_token: 'your access token')

# Fetch the employees of current commpany
client.employees

# fetch the settings of a company
client.get_company_settings

# list all webhooks of a company
client.webhooks
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/helloworld1812/wotc-ruby-gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

Here are some ways you can contribute:

- by reporting bugs
- by suggesting new features
- by writing or editing documentation
- by writing test case
- by writing code (no patch is too small: fix typos, add comments, clean up inconsistent whitespace)
- by refactoring code
- by closing issues
- by reviewing patches

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Wotc::Ruby::Gem project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/wotc-ruby-gem/blob/master/CODE_OF_CONDUCT.md).

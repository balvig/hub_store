# Hub Store

Save raw pull request and review metadata from GitHub for metrics
analysis etc.


## Usage

### Using inside an app
Add this line to your application's Gemfile:

```ruby
gem "hub_store"
```

Then:

```ruby
REPOS = "balvig/hub_store,balvig/hub_link"

HubStore::Importer.new(repos: REPOS, start_date: 4.weeks.ago).run
# => Imports pull request and review data to a local sqlite DB

HubStore::Exporter.new(resource: PullRequest).run
# => Exports pull request data from sqlite DB to `pull_requests.csv`

HubStore::Exporter.new(resource: Review).run
# => Exports review data from sqlite DB to `reviews.csv`
```

### Using from command line (WIP)

```bash
gem install hub_store
OCTOKIT_ACCESS_TOKEN=<token> hub_store <github_organization/repo_name>
# => Exports 2 years worth of PRs/Reviews to csv files
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hub_store. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HubStore project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hub_store/blob/master/CODE_OF_CONDUCT.md).

# Hub Store

Save raw pull request and review metadata from GitHub for metrics
analysis etc.

## Usage

Running the following will export all PR/Review metadata in a repo to CSV
files.

The gem will use an sqlite db as interim storage to allow resuming and
subsequent exports:

```bash
gem install hub_store
OCTOKIT_ACCESS_TOKEN=<token> hub_store <github_organization/repo_names>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hub_store. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HubStore project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hub_store/blob/master/CODE_OF_CONDUCT.md).

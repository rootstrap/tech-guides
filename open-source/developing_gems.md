# Gems
## Creating Gems/Rails Engines
When creating a plain Ruby Gem use the Bundler command:
```sh
$ bundle gem [name]
```

When creating a Rails Engine use the Rails command:
```sh
$ rails plugin new [name] --mountable
```

## Gem version
Keep gem version in a constant and use it like this:
```ruby
spec.version = [name]::VERSION
```

## Dependencies versions
Take into account to restrict not only the lower required version of dependencies but also the upper supported version so to not break apps if any of your dependencies changes their API. Normally you should fix just to the major version.

## Code quality tools
Make sure to add:
- `Rubocop`
- `Reek`

## Gemfile/Gemfile.lock/gemspec
- `Gemfile` should only have the `gemspec` directive. An exception is when you need to develop against a gem that hasn't yet been released, in this case you can declare that dependency in the Gemfile:
```ruby
gem 'rack', github: 'rack/rack'
```
- `Gemfile.lock` should be gitignored when developing gems.
- `gemspec` is the place to declare dependencies.

## Testing
Make the default rake task to run every intended check (tests, code analysis).
```sh
bundle exec rake
```

For testing against different versions of `gem` dependencies you should add a `gemfiles` folder and inside it declare each separate `Gemfile` which can be then used by the CI.

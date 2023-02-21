# Capistrano Systemd integration for GoodJob

Adds the following capistrano commands:

```sh
good_job:disable                    # Disable good_job systemd service
good_job:enable                     # Enable good_job systemd service
good_job:install                    # Install good_job systemd service
good_job:reload                     # Reload good_job service via systemd
good_job:restart                    # Restart good_job service via systemd
good_job:start                      # Start good_job service via systemd
good_job:status                     # Get good_job service status via systemd
good_job:stop                       # Stop good_job service via systemd
good_job:uninstall                  # Uninstall good_job systemd service
```


## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem 'capistrano-good-job', require: false
end
```

And then execute:

    $ bundle

```ruby
# Capfile

require 'capistrano/good_job'
install_plugin Capistrano::GoodJob
```

To prevent loading [the hooks](lib/capistrano/good_job.rb) of the plugin, add false to the load_hooks param.
```ruby
# Capfile

install_plugin Capistrano::GoodJob, load_hooks: false
```

Then run once

```sh
bundle exec cap production good_job:install
```

for the initial setup. This will copy a [`systemd` service definition](lib/capistrano/templates/good_job.service.erb) to `~/.config/systemd/user/symantiq_good_job.service` on your server marked with Capistrano role `db`.

It will also `enable` it in `systemd`, allowing to to then run commands such as:

```sh
systemctl --user status your_app_good_job_production
systemctl --user start your_app_good_job_production
systemctl --user stop your_app_good_job_production
systemctl --user reload your_app_good_job_production
systemctl --user restart your_app_good_job_production
```

through their Capistrano counterparts, ex: `bundle exec cap good_job:restart`.

## Usage

The plugin has registered a Capistrano `hook` to run `bundle exec cap good_job:restart` after deploy:

```ruby
after "deploy:finished", "good_job:restart"
```

See [`#register_hooks`](lib/capistrano/good_job.rb)


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mtomov/capistrano_good_job.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Credits

The structure and code of the gem are heavily inspired by [`capistrano-puma`](https://github.com/seuros/capistrano-puma)'s [`systemd` tasks](https://github.com/seuros/capistrano-puma/blob/master/lib/capistrano/tasks/systemd.rake)

# HealthCheck

[![Build Status](https://travis-ci.org/hirocaster/health_check.svg?branch=master)](https://travis-ci.org/hirocaster/health_check) [![Code Climate](https://codeclimate.com/github/hirocaster/health_check/badges/gpa.svg)](https://codeclimate.com/github/hirocaster/health_check)

Add monitor endpoint to rails app

## Installation

Add this line to your application's Gemfile:

    gem 'health_check'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install health_check

## Usage

./config/initializers/health_check.rb:

```ruby
HealthCheck.configure do |config|
  config.ping
  config.database # default ActiveRecord::Base
  config.redis    # default redis://127.0.0.1:6380/
end
```

### Multi databases

```ruby
HealthCheck.configure do |config|
  config.ping
  config.database.class_names = [ActiveRecord::Base, User, Item, Post] # Model classes
  config.redis
end
```

# HealthCheck

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
  config.redis
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

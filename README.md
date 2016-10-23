# README
A url shortening service written in Rails.

## Requirements
ruby > 2.3.0

## setup
```
bundle install
bundle exec rails db:setup
bundle exec rails s
```

## Testing
```
bundle exec rspec
```

## Todo
- Deploy to heroku
- Discuss design decisions
- Configure CI
- Discuss performance
- Discuss things I would do to get it to production
 - logging
 - error managing
 - Add counts (for times accessed)

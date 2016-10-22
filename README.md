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
- Setup and test GET route
- Setup active admim
- Don't allow creation of duplicate link
- Discuss performance
- Deploy to heroku
- Discuss design decisions
- Configure CI
- Discuss things I would do to get it to production
 - logging
 - error managing
 - Add counts (for times accessed)

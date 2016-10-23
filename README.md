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

## Design Decisions

### Tools and Ovar-all design
 - I used Rails because it's great for setting up a really fast project like this.
 - I used Rails Admin (with Basic Auth) because it is the fastest Admin system to set up. In a production environment, I'd probably switch to use devise for Digest Authentication so that multiple users can access the Admin interface more securely.
 - I don't allow creation of short urls for non-urls. Actually visiting the url to ensure it is valid is too slow, so I just used a REGEX expression to check.

### Performance

#### Storage Performance
 - We expect 5*100,000 urls to be generated each day. Urls average to about 80 characters long, so that's 80*10^5*80, which is around 1GB of data per month.

 Heroku has databases that that support up to 120GB of cache size, so we should be OK for storage for a few years. After that, we can start sharding our urls across multiple databases.

#### Speed performance
 - Assume each short url is accessed 5 times on average over it's life cycle.
 - If we have 500,000 urls per day, then in a year, we'll have around 100-200 Million urls created, and accessed 1Billion times. So read speed will have to be strongly optimized. Since the urls don't ever change, We can make strong use of caching (I'd set up several sharded Redis instances that are shared across all of the server instances). That way, we can limit access to our database to mostly writes.

### Ideas of how to improve shurl
 - Store the number of times a url is accessed.
 - Add better logging using papertrail
 - Add better error/exception management with Rollbar.
 - Add a splash page that uses our API
 - Allow browser AJAX access to our api by adding the coors gem.
 - Add user accounts so that they can manage their own urls.
 - (See storage/speed performance sections for ideas on performance)


## Todo
- Configure CI
- Discuss things I would do to get it to production
 - logging
 - error managing
 - Add counts (for times accessed)

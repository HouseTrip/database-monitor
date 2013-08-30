redis-monitor-tool
==================

A redis monitor tool that pushes data to Datadog

This program sends an `INFO` command to a redis server,
and forwards the important stats to DataDog.


Configuration
=============

Customization
----

The list of stats that are forwarded to Datadog can be configurated at
`./config/relevant_attributes.yml`


Env
-----

You must configure this enviroment variables to run the service:

```
DATADOG_API
REDIS_HOST
REDIS_PASSWORD
REDIS_PORT
```

if deploying on heroku it's as easy as:

```
heroku config:set DATADOG_API=ZZZZZZZZ
```

Running/Deploying to Heroku
==========

Be sure you have heroku-toolbelt installed:

```
brew install heroku-toolbelt
```

Add the heroku git repository to your git remote, for example:

```
git remote add heroku git@heroku.com:redis-monitor-tool.git
```

Be sure you have the env variables in heroku correct:

```
heroku config
#=> === Config Vars for redis-monitor-tool
#=> DATADOG_API:    some_api_key_should_be_here
#=> REDIS_HOST:     your_redis_host_url_should_be_here
#=> REDIS_PASSWORD: the_password_to_it_if_any
#=> REDIS_PORT:     the_port_your_redis_is_running
```

If it's not, use the `heroku config:set` to add them (see configuration).

The command heroku will run is at `./Procfile`, to deploy just:

```
git push heroku master
```

note that the running branch on heroku is always the master, you can
cross push branches, but the heroku side must always be the master branch.

Everytime you deploy your app should restart, you still can restart it manually if
you want with `heroku restart`

To verify if everything is running you can check the logs:

```
heroku --logs --tail

#=> 2013-08-30T12:47:02.307760+00:00 app[worker.1]: [rufus 2013-08-30 12:47:02.307] scheduler started
#=> 2013-08-30T12:47:02.776333+00:00 app[worker.1]: [rufus 2013-08-30 12:47:02.309] scheduled 'redis_information_push'
#=> 2013-08-30T12:48:02.598359+00:00 app[worker.1]: [rufus 2013-08-30 12:48:02.597] redis_information_push(3f9948dca958): starting
#=> 2013-08-30T12:48:12.638341+00:00 app[worker.1]: [rufus 2013-08-30 12:48:12.638] redis_information_push(3f9948dca958): completed in 10.040 s
#=> ...
```

You can also verify if it's running with the ps command:

```
heroku ps
#=> === worker: `bundle exec rufus-runner config/schedule.rb`
#=> worker.1: up for 44m
```

If you are deploying to a new heroku server and the process doesn't seem to have started,
try to force the dynos counter:

```
heroku ps:scale worker=1
```


Running Locally
==========

To run the service standalone:

```
./bin/redis_monitor
```

To run it in a loop every 60s:

```
bundle exec rufus-runner config/schedule.rb
```

It will require that you have a valid configuration (see above).
If your redis configurations is empty, it will try to run against
a local redis.

To install and run redis on your machine:

```
brew install redis
redis-server
```

Running Tests
=============

* Have redis running on your machine (`brew install redis && redis-server`)
* `bundle exec rake`


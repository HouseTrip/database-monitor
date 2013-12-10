Watchdog
==================

A service monitoring tool that pushes data to Datadog

This program queries a service and forwards the important stats to DataDog.


Configuration
=============

Customization
----

You can decide what services to track by commenting out the unnecessary rufus tasks
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
MONGO_HOST
MONGO_PORT
MONGO_DB
MONGO_USER
MONGO_PASSWORD
```

if deploying on heroku it's as easy as:

```shell
heroku config:set DATADOG_API=ZZZZZZZZ
```

Running/Deploying to Heroku
==========

Be sure you have heroku-toolbelt installed:

```shell
brew install heroku-toolbelt
```

Add the heroku git repository to your git remote, for example:

```shell
git remote add heroku git@heroku.com:watchdog.git
```

Be sure you have the env variables in heroku correct:

```shell
heroku config
#=> === Config Vars for watchdog
#=> DATADOG_API:    some_api_key_should_be_here
#=> REDIS_HOST:     your_redis_host_url_should_be_here
#=> REDIS_PASSWORD: the_password_to_it_if_any
#=> REDIS_PORT:     the_port_your_redis_is_running
#=> MONGO_HOST:     mongo_server_address
#=> MONGO_PORT:     the_port_mongo_is_running_on
#=> MONGO_DB:       the_database_you_want_to_watch
#=> MONGO_USER:     login_username
#=> MONGO_PASSWORD: login_password

```

If it's not, use the `heroku config:set` to add them (see configuration).

The command heroku will run is at `./Procfile`, to deploy just:

```shell
git push heroku master
```

note that the running branch on heroku is always the master, you can
cross push branches, but the heroku side must always be the master branch.

Everytime you deploy your app should restart, you still can restart it manually if
you want with `heroku restart`

To verify if everything is running you can check the logs:

```shell
heroku logs --tail

#=> 2013-08-30T12:47:02.307760+00:00 app[worker.1]: [rufus 2013-08-30 12:47:02.307] scheduler started
#=> 2013-08-30T12:47:02.776333+00:00 app[worker.1]: [rufus 2013-08-30 12:47:02.309] scheduled 'redis_information_push'
#=> 2013-08-30T12:47:02.776333+00:00 app[worker.1]: [rufus 2013-12-10 14:52:12.469] scheduled 'mongo_information_push'
#=> 2013-08-30T12:48:02.598359+00:00 app[worker.1]: [rufus 2013-08-30 12:48:02.597] redis_information_push(3f9948dca958): starting
#=> 2013-08-30T12:48:12.638341+00:00 app[worker.1]: [rufus 2013-08-30 12:48:12.638] redis_information_push(3f9948dca958): completed in 10.040 s
#=> 2013-12-10T14:53:12.628959+00:00 app[worker.1]: [rufus 2013-12-10 14:53:12.628] mongo_information_push(3f810cc16f70): starting
#=> 2013-12-10T14:53:16.584456+00:00 app[worker.1]: [rufus 2013-12-10 14:53:16.584] mongo_information_push(3f810cc16f70): completed in 3.956 s
#=> ...
```

You can also verify if it's running with the ps command:

```shell
heroku ps
#=> === worker: `bundle exec rufus-runner config/schedule.rb`
#=> worker.1: up for 44m
```

If you are deploying to a new heroku server and the process doesn't seem to have started,
try to force the dynos counter:

```shell
heroku ps:scale worker=1
```

Pointing it to a different redis/mongo server
-----

If you need to change the redis-server being monitored you don't need to change any code.
You can do it simply by changing the herokus configuration for REDIS:

```shell
heroku config:set REDIS_HOST=new_host REDIS_PORT=new_port REDIS_PASSWORD=new_password
```
Note that it will automatically restart when you change any configuration variable.


Running Locally
==========

To run the service standalone:

```shell
./bin/watchdog
```

To run it in a loop every 60s:

```shell
bundle exec rufus-runner config/schedule.rb
```

It will require that you have a valid configuration (see above).
If your redis/mongo configurations is empty, it will try to run against
a local server.

To install and run redis on your machine:

```shell
brew install redis
redis-server
```

To install and run mongo on your machine:

```shell
brew install mongo
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
```

Running Tests
=============

* Have redis and mongo running on your machine
* `bundle exec rake`


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
If your redis configurations are empty, it will try to run against
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


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

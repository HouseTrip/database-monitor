redis-monitor-tool
==================

A redis monitor tool that pushes data to Datadog


Configuration
=============

You must configure this enviromental variables to run the service:

```
DATADOG_API
DATADOG_APP
REDIS_HOST
REDIS_PASSWORD
REDIS_PORT
```

if deploying on heroku it's as easy as:

```
heroku config:set DATADOG_API=ZZZZZZZZ
```

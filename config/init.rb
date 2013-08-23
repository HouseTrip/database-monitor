require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'redis'
RedisConnection = Redis.new(
  :dns => (ENV['REDIS_DNS'] || 'localhost'),
  :port => (ENV['REDIS_PORT'] || '6379')
)

require 'dogapi'
DataDogClient = Dogapi::Client.new(
  ENV['DATADOG_API'] || 'dummy',
  ENV['DATADOG_APP'] || 'f757260a80ff5f8018ba3d70656f3ba693d794aa'
)

require File.expand_path('../../lib/redis_monitor', __FILE__)

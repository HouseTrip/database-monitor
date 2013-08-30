require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'redis'
RedisConnection = Redis.new(
  :host => (ENV['REDIS_HOST'] || 'localhost'),
  :port => (ENV['REDIS_PORT'] || '6379'),
  :password => ENV['REDIS_PASSWORD']
)

require 'dogapi'
DataDogClient = Dogapi::Client.new(ENV['DATADOG_API'] || 'dummy')

require_relative '../lib/redis_monitor'

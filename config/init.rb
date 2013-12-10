require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'redis'
RedisConnection = Redis.new(
  :host => (ENV['REDIS_HOST'] || 'localhost'),
  :port => (ENV['REDIS_PORT'] || '6379'),
  :password => ENV['REDIS_PASSWORD']
)

require 'mongo'
mongo_uri = ENV['MONGO_URI'] || 'mongodb://localhost:27017/'
MongoConnection = Mongo::Connection.from_uri(mongo_uri)

require 'dogapi'
DataDogClient = Dogapi::Client.new(ENV['DATADOG_API'] || 'dummy')

require_relative '../lib/watchdog'

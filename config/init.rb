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
mongo_host     = ENV['MONGO_HOST'] || 'localhost'
mongo_port     = ENV['MONGO_PORT'] || 27017
mongo_db       = ENV['MONGO_DB']   || ''
mongo_user     = ENV['MONGO_USER'] || ''
mongo_password = ENV['MONGO_PASSWORD'] || ''
MongoConnection = Mongo::Connection.from_uri("mongodb://#{mongo_user}:#{mongo_password}@#{mongo_host}:#{mongo_port}/#{mongo_db}")

require 'dogapi'
DataDogClient = Dogapi::Client.new(ENV['DATADOG_API'] || 'dummy')

require_relative '../lib/watchdog'

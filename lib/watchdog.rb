require_relative 'watchdog/version'
require_relative 'watchdog/redis_monitor'
require_relative 'watchdog/mongo_monitor'
require_relative 'watchdog/shared/datadog_pusher'
require_relative 'watchdog/shared/information_filter'

module Watchdog
  def self.run
    Watchdog::RedisMonitor.run
    Watchdog::MongoMonitor.run
  end
end
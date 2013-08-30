require_relative 'redis_monitor/information_filter'
require_relative 'redis_monitor/datadog_pusher'

module RedisMonitor
  def self.run
    info = RedisConnection.info
    info = InformationFilter.new(info).relevant_only
    DataDogPusher.new.push(info)
  end
end

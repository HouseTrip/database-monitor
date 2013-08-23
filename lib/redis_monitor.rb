require File.expand_path('../redis_monitor/information_filter', __FILE__)
require File.expand_path('../redis_monitor/datadog_pusher', __FILE__)

module RedisMonitor
  def self.run
    info = RedisConnection.info
    info = InformationFilter.new(info).relevant_only
    DataDogPusher.new.push(info)
  end
end

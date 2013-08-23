require File.expand_path('../redis_monitor/redis_adaptor', __FILE__)
require File.expand_path('../redis_monitor/information_filter', __FILE__)

module RedisMonitor
  def self.run
    info = RedisAdaptor.connection.info
    info = InformationFilter.new(info).relevant_only
    DataDogPusher.new(info).push
  end
end

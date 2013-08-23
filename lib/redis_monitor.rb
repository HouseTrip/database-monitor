require File.expand_path('../redis_adaptor', __FILE__)
require File.expand_path('../information_filter', __FILE__)

module RedisMonitor
  def self.run
    info = RedisAdaptor.connection.info
    info = InformationFilter.new(info).relevant_only
    DataDogPusher.new(info).push
  end
end

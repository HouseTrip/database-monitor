require 'database_monitor/shared/datadog_pusher'
require 'database_monitor/shared/information_filter'

module DatabaseMonitor
  module RedisMonitor
    def self.run
      stats = RedisConnection.info
      info  = InformationFilter.new('redis', stats).relevant_only
      DataDogPusher.push('redis', info)
    end
  end
end

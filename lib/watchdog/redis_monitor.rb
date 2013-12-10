module Watchdog
  module RedisMonitor
    def self.run
      stats = RedisConnection.info
      info  = InformationFilter.new('redis', stats).relevant_only
      DataDogPusher.push('redis', info)
    end
  end
end

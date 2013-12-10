module Watchdog
  module RedisMonitor
    def self.run
      info = RedisConnection.info
      info = InformationFilter.new('redis', info).relevant_only
      DataDogPusher.new.push('redis', info)
    end
  end
end

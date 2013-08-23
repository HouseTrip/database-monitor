require 'redis'

module RedisMonitor
  module RedisAdaptor

    def self.connection
      @connection = Redis.new(
        :dns => (ENV['REDIS_DNS'] || 'localhost'),
        :port => (ENV['REDIS_PORT'] || '6379')
      )
    end

  end
end

module RedisMonitor
  class DataDogPusher

    def push(data)
      data.each_pair do |metric, value|
        DataDogClient.emit_point("redis.#{metric}", value)
      end
    end

  end
end

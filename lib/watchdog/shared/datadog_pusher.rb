module Watchdog
  class DataDogPusher

    def push(type, data)
      data.each_pair do |metric, value|
        DataDogClient.emit_point("#{type}.#{metric}", value)
      end
    end

  end
end

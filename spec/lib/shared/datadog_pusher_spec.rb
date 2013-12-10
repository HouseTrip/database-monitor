require 'spec_helper'

module Watchdog
  describe DataDogPusher do
    it 'should push each key and value to datadog' do
      info = { 'metric1' => 100, 'metric2' => 200 }
      info.each_pair do |metric, value|
        DataDogClient.should_receive(:emit_point).with("redis.#{metric}", value)
      end
      DataDogPusher.new.push('redis', info)
    end
  end
end

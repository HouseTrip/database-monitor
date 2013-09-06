require_relative 'init'

Rufus::TrackingScheduler.start do |scheduler|
  scheduler.run :name => 'redis_information_push', :every => '60s' do
    RedisMonitor.run
  end
end

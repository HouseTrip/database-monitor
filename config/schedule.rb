require_relative 'init'

Rufus::TrackingScheduler.start do |scheduler|
  scheduler.run :name => 'redis_information_push', :every => '60s' do
    Watchdog::RedisMonitor.run
  end
  scheduler.run :name => 'mongo_information_push', :every => '60s' do
    Watchdog::MongoMonitor.run
  end
end

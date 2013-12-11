require 'database_monitor/redis_monitor'
require 'database_monitor/mongo_monitor'

module DatabaseMonitor
  def self.run
    DatabaseMonitor::RedisMonitor.run
    DatabaseMonitor::MongoMonitor.run
  end
end
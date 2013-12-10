module Watchdog
  module MongoMonitor
    def self.run
      stats = MongoConnection.db.stats
      info  = InformationFilter.new('mongo', stats).relevant_only
      DataDogPusher.push("mongo.#{MongoConnection.db.name}", info)
    end
  end
end

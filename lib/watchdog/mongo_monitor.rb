module Watchdog
  module MongoMonitor
    def self.run
      info = MongoConnection.db.stats
      info = InformationFilter.new('mongo', info).relevant_only
      DataDogPusher.new.push("mongo.#{MongoConnection.db.name}", info)
    end
  end
end

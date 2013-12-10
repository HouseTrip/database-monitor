module Watchdog
  module MongoMonitor
    def self.run
      info = MongoConnection.db.stats
      info = InformationFilter.new('mongo', info).relevant_only
      DataDogPusher.new.push('mongo', info)
    end
  end
end

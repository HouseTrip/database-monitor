require 'spec_helper'

describe RedisAdaptor do
  describe "#connection" do
    it "should returns a successfull connection with redis" do
      expect {
        RedisAdaptor.connection.should be_a(Redis)
      }.to_not raise_error
    end
  end
end

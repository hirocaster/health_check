describe "HealthCheck::Plugins::Redis" do
  describe "example" do
    before do
      HealthCheck.configure do |config|
        config.redis
      end
    end

    it "check default redis host" do
      expect {
        redis = HealthCheck::Plugins::Redis.new
        redis.check!
      }.not_to raise_error
    end
  end

  context "Redis returns other value from redis server" do
    before do
      redis = ::Redis.new
      allow(redis).to receive(:get).and_return "faild value"
      allow(::Redis).to receive(:new).and_return redis
    end

    it "raise different values exception" do
      expect {
        redis = HealthCheck::Plugins::Redis.new
        redis.check!
      }.to raise_error HealthCheck::Plugins::RedisException
    end
  end

  context "Set redis server urls" do
    it "check redis host" do
      expect {
        redis = HealthCheck::Plugins::Redis.new
        redis.check_urls = ["redis://127.0.0.1:6381/"]
        redis.check!
      }.not_to raise_error
    end
  end
end

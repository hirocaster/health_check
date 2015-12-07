describe "HealthCheck::Plugins::Redis" do
  describe "example" do
    before do
      HealthCheck.configure(&:redis)
    end

    it "check default redis host" do
      redis = HealthCheck::Plugins::Redis.new
      expect(redis.check!).to eq "redis://127.0.0.1:6380/": "OK"
    end
  end

  context "Redis returns other value from redis server" do
    before do
      redis = ::Redis.new
      allow(redis).to receive(:get).and_return "faild value"
      allow(::Redis).to receive(:new).and_return redis
    end

    it "raise different values exception" do
      expect do
        redis = HealthCheck::Plugins::Redis.new
        redis.check!
      end.to raise_error HealthCheck::Plugins::RedisException
    end
  end

  context "Set redis server urls" do
    it "check redis host" do
      expect do
        redis = HealthCheck::Plugins::Redis.new
        redis.check_urls = ["redis://127.0.0.1:6381/"]
        redis.check!
      end.not_to raise_error
    end
  end
end

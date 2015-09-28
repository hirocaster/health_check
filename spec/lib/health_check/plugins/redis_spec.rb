describe "HealthCheck::Plugins::Redis" do

  it "example" do
    expect {
      redis = HealthCheck::Plugins::Redis.new
      redis.check!
    }.not_to raise_error
  end

  context "Redis returns other value" do
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

end

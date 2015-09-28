describe "HealthCheck::Plugins::Redis" do

  it "example" do
    expect {
      redis = HealthCheck::Plugins::Redis.new
      redis.check!
    }.not_to raise_error
  end

end

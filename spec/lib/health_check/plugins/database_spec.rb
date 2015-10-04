describe "HealthCheck::Plugins::Database" do
  describe "example" do
    before do
      HealthCheck.configure do |config|
        config.database
      end
    end

    it "check default database host" do
      expect {
        database = HealthCheck::Plugins::Database.new
        database.check!
      }.not_to raise_error
    end
  end
end

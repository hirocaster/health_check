describe "HealthCheck::Plugins::Database" do
  describe "example" do
    before do
      HealthCheck.configure(&:database)
    end

    it "check default database host" do
      expect do
        database = HealthCheck::Plugins::Database.new
        database.check!
      end.not_to raise_error
    end
  end
end

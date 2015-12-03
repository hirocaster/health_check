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

    it "returns deault check database classes" do
      database = HealthCheck::Plugins::Database.new
      expect(database.class_names).to eq [ActiveRecord::Base]
    end

    it "returns configured check database classes" do
      database = HealthCheck::Plugins::Database.new
      database.class_names = [ActiveRecord::Base, User]
      expect(database.class_names).to eq [ActiveRecord::Base, User]
    end
  end
end

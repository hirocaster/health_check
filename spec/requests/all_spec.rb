describe "All", type: :request do
  describe "GET /all" do
    before do
      HealthCheck.configure do |config|
        config.ping
        config.database
        config.redis
      end
    end

    context "example" do
      it "returns json" do
        get "/health_check/all"
        expect(response).to be_success
        expect(response).to have_http_status 200
        expect(response.body).to have_json_path "results"
        expect(response.body).to have_json_path "results/ping"
        expect(response.body).to have_json_path "results/ping/status"
        expect(response.body).to have_json_path "results/ping/message"
        expect(response.body).to have_json_path "results/ping/timestamp"
        expect(response.body).to have_json_path "results/database"
        expect(response.body).to have_json_path "results/database/status"
        expect(response.body).to have_json_path "results/database/message"
        expect(response.body).to have_json_path "results/database/message/ActiveRecord::Base"
        expect(response.body).to have_json_path "results/database/timestamp"
        expect(response.body).to have_json_path "results/redis"
        expect(response.body).to have_json_path "results/redis/status"
        expect(response.body).to have_json_path "results/redis/message"
        expect(response.body).to have_json_path "results/redis/timestamp"
        expect(response.body).to be_json_eql(%("OK")).at_path("status")
      end
    end


    context "Set add user model class" do
      before do
        HealthCheck.configure do |config|
          config.ping
          config.database.class_names = [ActiveRecord::Base, User]
          config.redis
        end
      end

      it "returns json" do
        get "/health_check/all"
        expect(response.body).to be_json_eql(%("OK")).at_path("status")
        expect(response.body).to be_json_eql(%("OK")).at_path("results/database/status")
        expect(response.body).to be_json_eql(%("OK")).at_path("results/database/message/User/")
      end
    end

    context "Set multi classes" do
      it "returns json" do
        get "/health_check/all"
        expect(response.body).to be_json_eql(%("OK")).at_path("status")
        expect(response.body).to be_json_eql(%("OK")).at_path("results/database/status")
      end
    end

    context "have error status" do
      before do
        allow_any_instance_of(HealthCheck::Plugins::Ping).to receive(:check!).with(anything).and_raise HealthCheck::Plugins::PingException
      end

      it "returns status NG json" do
        get "/health_check/all"
        expect(response).to be_success
        expect(response).to have_http_status 200
        expect(response.body).to have_json_path "results"
        expect(response.body).to be_json_eql(%("NG")).at_path("status")
      end
    end
  end
end

describe "All", :type => :request do
  describe "GET /all" do
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
        expect(response.body).to have_json_path "results/database/timestamp"
        expect(response.body).to be_json_eql(%("OK")).at_path("status")
      end
    end

    context "Set database_check_classes parameter" do
      it "returns json" do
        get "/health_check/all?database_check_classes=ActiveRecord::Base"
        expect(response.body).to be_json_eql(%("OK")).at_path("status")
        expect(response.body).to be_json_eql(%("OK")).at_path("results/database/status")
      end

      context "Set user generate model class" do
        it "returns json" do
          get "/health_check/all?database_check_classes=User"
          expect(response.body).to be_json_eql(%("OK")).at_path("status")
          expect(response.body).to be_json_eql(%("OK")).at_path("results/database/status")
        end
      end

      context "Set multi classes" do
        it "returns json" do
          get "/health_check/all?database_check_classes=ActiveRecord::Base,User"
          expect(response.body).to be_json_eql(%("OK")).at_path("status")
          expect(response.body).to be_json_eql(%("OK")).at_path("results/database/status")
        end
      end
    end

    context "Set redis_check_urls parameter" do
      it "returns json" do
        get "/health_check/all?redis_check_urls=redis://127.0.0.1:6380/"
        expect(response.body).to be_json_eql(%("OK")).at_path("status")
        expect(response.body).to be_json_eql(%("OK")).at_path("results/redis/status")
      end
    end

    context "have error status" do
      before do
        ping = HealthCheck::Plugins::Ping.new
        allow(ping).to receive(:check!).and_raise HealthCheck::Plugins::PingException
        allow(HealthCheck::Plugins::Ping).to receive(:new).and_return ping
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

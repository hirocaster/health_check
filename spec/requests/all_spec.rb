describe "All", :type => :request do
  describe "GET /all" do
    it "returns json" do
      get "/health_check/all"
      expect(response).to be_success
      expect(response.body).to be_json_eql(%("ok")).at_path("result")
    end
  end
end

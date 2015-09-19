require_dependency "health_check/application_controller"

module HealthCheck
  class AllController < ApplicationController
    def index
      render json: { result: "ok"}
    end
  end
end

require_dependency "health_check/application_controller"

module HealthCheck
  class AllController < ApplicationController
    def index
      render json: HealthCheck.all_check(request: request)
    end
  end
end

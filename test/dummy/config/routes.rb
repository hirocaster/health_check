Rails.application.routes.draw do

  mount HealthCheck::Engine => "/health_check"
end

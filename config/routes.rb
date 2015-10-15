HealthCheck::Engine.routes.draw do
  get "/all", controller: :all, action: :index
end

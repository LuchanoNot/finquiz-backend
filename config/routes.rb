Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "auth"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :home, only: [ :index ]
    end
  end
end

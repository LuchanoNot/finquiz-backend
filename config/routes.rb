Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth"

      resources :courses, only: [ :show, :update ] do
        resources :units, only: [ :show, :create, :update ] do
          resources :topics, only: [ :create, :update, :destroy ]
        end
      end

      resources :questionnaires, only: [ :index, :show ] do
        get :summary, on: :member

        resources :questions, only: [ :show ] do
          post :answer, on: :member
        end
      end
    end
  end
end

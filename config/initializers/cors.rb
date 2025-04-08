# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch("FRONTEND_URL", "http://localhost:5173")

    resource "*",
      headers: :any,
      expose: [ "access-token", "expiry", "token-type", "uid", "client" ],
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
      credentials: true
  end
end

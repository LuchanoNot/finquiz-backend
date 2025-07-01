require_relative "boot"

require "rails/all"
require "csv"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinQuizBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    config.autoload_lib(ignore: %w[assets tasks])
    config.autoload_paths += %W[#{config.root}/app/services/concerns]


    # Sidekiq setup
    config.active_job.queue_adapter = :sidekiq

    # Skip views, helpers and assets when generating a new resource.
    config.session_store :cookie_store, key: "_finquiz_backend_session"
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options

    config.api_only = true

    config.i18n.default_locale = :es
  end
end

source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "pg", "~> 1.5", ">= 1.5.9"
gem "puma", ">= 5.0"
gem "jbuilder", "~> 2.13"

gem "devise", "~> 4.9", ">= 4.9.4"
gem "devise_token_auth", "~> 1.2", ">= 1.2.5"
gem "omniauth", "~> 2.1", ">= 2.1.3"

# Use the database-backed adapters for Rails.cache and Active Job
gem "solid_cache"
gem "solid_queue"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

gem "sidekiq", "~> 8.0", ">= 8.0.1"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"


gem "rack-cors", "~> 2.0", ">= 2.0.2"

gem "devise-i18n", "~> 1.9", ">= 1.9.2"

gem "cancancan", "~> 3.6", ">= 3.6.1"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  gem "rspec-rails", "~> 7.1", ">= 7.1.1"
  gem "factory_bot_rails", "~> 6.4", ">= 6.4.4"
  gem "faker", "~> 3.5", ">= 3.5.1"
  gem "database_cleaner", "~> 2.1"
  gem "shoulda-matchers", "~> 6.1"

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", "~> 1.1"

  gem "dotenv-rails", "~> 3.1", ">= 3.1.7"
end

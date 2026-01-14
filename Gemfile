source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.4"

# The modern asset pipeline for Rails
gem "propshaft"

# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"

# Use the Puma web server
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire
gem "turbo-rails"
gem "stimulus-rails"

# Build JSON APIs
gem "jbuilder"

# Windows time zone support
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Database-backed adapters
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Boot speed
gem "bootsnap", require: false

# Deployment
gem "kamal", require: false
gem "thruster", require: false


gem "devise", "~> 4.9"
gem "kaminari"
gem "aasm"


gem "carrierwave", "2.1.1"
gem "mimemagic", "0.4.3"


gem "sidekiq", "~> 7.3"
gem "connection_pool", "~> 3.0"

# -------------------------
# Development & Test
# -------------------------
group :development, :test do
  # Debugging
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Security & code style
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false

 
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

# -------------------------
# Test only
# -------------------------
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

# -------------------------
# Development only
# -------------------------
group :development do
  gem "web-console"
end

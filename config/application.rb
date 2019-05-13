require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Getnextid
    class Application < Rails::Application
        # Initialize configuration defaults for originally generated Rails version.
        config.load_defaults 5.2
        
        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration can go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded after loading
        # the framework and any gems in your application.
        config.middleware.use Rack::Attack
    end
end

Raven.configure do |config|
    config.dsn = 'https://5d41752db3764caab8e112de578d50e9:128e0efc07c6460ca412fd5213ff2c32@sentry.io/1458055'
end

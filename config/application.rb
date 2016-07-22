require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Crafters
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_mailer.delivery_method = :smtp
    # SMTP settings for gmail
    config.action_mailer.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :user_name => "craftersmain@gmail.com",
      :password => ENV["GMAIL_PASSWORD"],
      :authentication => "plain",
      :enable_starttls_auto => true
    }
    config.action_mailer.raise_delivery_errors = true
    config.i18n.available_locales = [:hu, :en]
  end
end

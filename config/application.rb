require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Reimagina
  class Application < Rails::Application


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
      config.i18n.default_locale = :es

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Handle exceptions
    config.exceptions_app = self.routes

     # Autoload paths
    config.autoload_paths += %w("#{config.root}/lib")

    #vagrant permissions
    config.web_console.development_only = false
    config.active_job.queue_adapter = :sidekiq
    config.web_console.whitelisted_ips = '10.0.2.2'

    #sidekiq free memory after workers done
     config.middleware.delete "Mongoid::QueryCache"
     config.middleware.delete "ActiveRecord::QueryCache"
  end
end

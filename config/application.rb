require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Catalks
  class Application < Rails::Application
    
    config.time_zone = "Tokyo"
    config.i18n.default_locale = :ja 
    config.i18n.load_path +=
      Dir[Rails.root.join("config", "localse", "**", "*.{rb,yml}").to_s]
    config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]
    
    config.exceptions_app = ->(env) do 
      ErrorsController.action(:show).call(env)
    end
    
    config.generators do |g| 
      g.skip_routes true
      g.helper false 
      g.assets false 
      g.test_framework :rspec
      g.controller_specs false 
      g.view_specs false 
    end
    
    Rails.application.config.active_record.sqlite3.represent_boolean_as_integer = true
  end
end

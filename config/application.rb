require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Intern2020ManagementTraining
  class Application < Rails::Application
    config.load_defaults 6.0
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]
    config.i18n.available_locales = %i(en vi)
    config.i18n.default_locale = :en
  end
end

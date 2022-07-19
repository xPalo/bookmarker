require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)
Dotenv::Railtie.load

module Bookmarker
  class Application < Rails::Application
    config.load_defaults 7.0
    config.active_storage.variant_processor = :mini_magick
    config.i18n.available_locales = [:en, :sk]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
  end
end
require File.expand_path('../boot', __FILE__)

require 'rails/all'

# HAS: 20131203 Getting all config variables from application.yml
CONFIG = YAML.load(File.read(File.expand_path('../application.yml', __FILE__)))
CONFIG.merge! CONFIG.fetch(Rails.env, {})
CONFIG.symbolize_keys!


Bundler.require(:default, Rails.env)

module Mercator
  class Application < Rails::Application
    I18n.enforce_available_locales = true
    I18n.available_locales = [:en]

    # Hobo: the contracting subsite loads contracting.css & contracting.js
    config.assets.precompile += %w(contracting.css contracting.js contracting2.css contracting2.js)

    config.generators do |g|
      g.test_framework :rspec, :fixtures => true
      g.fallbacks[:rspec] = :test_unit
      g.fixture_replacement = :factory_girl_rails
    end

    config.hobo.dont_emit_deprecated_routes = true
    config.assets.precompile += %w(front.css front.js)

    config.i18n.load_path += Dir[Rails.root.join('locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.active_record.whitelist_attributes = true
    config.assets.version = '1.0'

    config.generators do |generator|
      generator.test_framework :rspec,
      fixtures: true,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: true,
      request_specs: false
      generator.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    config.time_zone = 'Vienna'
    config.active_record.default_timezone = :local
    # config.hobo.show_translation_keys = true

    config.ember.app_name = "Contracting"
    config.handlebars.templates_root = "contracting/templates"
    config.handlebars.precompile = true
  end
end

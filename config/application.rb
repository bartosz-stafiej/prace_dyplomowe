require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module PraceDyplomowe
  class Application < Rails::Application
    config.load_defaults 6.1
    config.active_record.schema_format = :sql
  end
end

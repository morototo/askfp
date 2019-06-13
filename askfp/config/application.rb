require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Askfp
  class Application < Rails::Application
    config.load_defaults 5.2
    config.generators.template_engine = :slim 
  end
end

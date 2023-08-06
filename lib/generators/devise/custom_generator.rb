require 'rails/generators/base'

module Devise
  module Generators
    class CustomGenerator < Rails::Generators::Base

        source_root File.expand_path('templates', __dir__)
    end
  end
end

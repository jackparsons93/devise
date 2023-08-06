require 'rails/generators/base'

module Devise
  module Generators
    class CustomGenerator < Rails::Generators::Base

        source_root File.expand_path('templates', __dir__)
        def copy_model

          template "model.rb", "app/models/model.rb"
        end
    end
  end
end

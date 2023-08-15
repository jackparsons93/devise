require 'rails/generators/base'

module Devise
  module Generators
    class CustomGenerator < Rails::Generators::Base
      # CONTROLLERS = %w(confirmations passwords registrations sessions unlocks omniauth_callbacks).freeze
      
      argument :scope, required: false
      class_option :attributes, aliases: "-a", type: :hash, default: {}
        source_root File.expand_path('templates', __dir__)
        def copy_model
          if scope
          template "model.rb", "app/models/#{scope}.rb"
          else 
            template "model.rb", "app/models/model.rb"
          end
        end
        def create_controllers
          
          #@scope_prefix = scope.blank? ? '' : (scope.camelize + '::')
          controllers = %w(confirmations passwords registrations sessions unlocks omniauth_callbacks)
          template "controllers/registrations_controller.rb",
          "app/controllers/users/registrations_controller.rb"
          if scope
          controllers.each do |name|
            puts name 
            template "controllers/#{name}_controller.rb",
                     "app/controllers/#{scope.pluralize}/#{name}_controller.rb"
          end
        end
      end

      
        
    end
  end
end

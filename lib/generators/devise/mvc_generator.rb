require 'rails/generators/base'
require 'generators/active_record/devise_generator.rb'
require 'rails/generators/active_record'
require 'generators/devise/orm_helpers'
require 'generators/devise/devise_generator.rb'
require "generators/devise/views_generator.rb"
module Devise
  module Generators
    class MvcGenerator < ActiveRecord::Generators::Base
      include Rails::Generators::ResourceHelpers
      source_root File.expand_path('templates', __dir__)
      argument :attributes, type: :hash, default: {}
      def invoke_model
        invoke ActiveRecord::Generators::DeviseGenerator
      end
      def copy_routes
          template "routes.rb" , "config/routes.rb"
      end

              
      def create_views
      invoke Devise::Generators::ViewsGenerator
      end

  
      def create_controllers
      invoke Devise::Generators::ControllersGenerator
      end

      def configure_data_for_views
        view_string=""
        if attributes
          attributes.each do |attribute|
            view_string << '<div class="field">'+ "\n"
            view_string << "<p><%= f.label :#{attribute.name[0]} %></p>"+"\n"
            view_string << "<p><%= f.text_field  :#{attribute.name[0]},  %></p>" +"\n"
            view_string << "</div>" +"\n"
          end
        end
        return view_string
    end
      
      def add_devise_authentication_filter_to_application_controller
        insert_into_file "app/views/#{name.pluralize}/registrations/new.html.erb", "#{configure_data_for_views}\n", before: /<div class="actions">/
      end
    end
  end
end
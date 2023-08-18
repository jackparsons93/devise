require 'rails/generators/base'
require 'generators/active_record/devise_generator.rb'
require 'rails/generators/active_record'
require 'generators/devise/orm_helpers'
require 'generators/devise/devise_generator.rb'
module Devise
  module Generators
    class MvcGenerator < ActiveRecord::Generators::Base
      include Rails::Generators::ResourceHelpers

      def invoke_model
        invoke ActiveRecord::Generators::DeviseGenerator, [name]
      end

      def invoke_routes
        invoke Devise::Generators::DeviseGenerator, [name]
      end

    end
  end
end
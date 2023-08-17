require 'rails/generators/base'
require 'generators/active_record/devise_generator.rb'
require 'rails/generators/active_record'
require 'generators/devise/orm_helpers'
module Devise
  module Generators
    class MvcGenerator < ActiveRecord::Generators::Base

      def invoke_model
        invoke ActiveRecord::Generators::DeviseGenerator, [name]
      end
    
    end
  end
end
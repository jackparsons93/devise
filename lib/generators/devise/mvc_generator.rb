require 'rails/generators/base'
require 'generators/active_record/devise_generator.rb'
require 'rails/generators/active_record'
require 'generators/devise/orm_helpers'
require 'generators/devise/devise_generator.rb'
module Devise
  module Generators
    class MvcGenerator < ActiveRecord::Generators::Base
      include Rails::Generators::ResourceHelpers
      source_root File.expand_path('templates', __dir__)
      class_option :attributes, aliases: "-a", type: :hash, default: {}
      argument :attributes, type: :array, default: [], banner: "field:type field:type"
      def invoke_model
        invoke ActiveRecord::Generators::DeviseGenerator, [name]
      end
      def copy_routes
          template "routes.rb" , "config/routes.rb"
      end

              
        def view_template
view=<<RUBY
          <h2>Sign up</h2>

          <%= simple_form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
            <%= f.error_notification %>
          
            <div class="form-inputs">
              <%= f.input :email,
                          required: true,
                          autofocus: true,
                          input_html: { autocomplete: "email" }%>
              <%= f.input :password,
                          required: true,
                          hint: ("#{@minimum_password_length} characters minimum" if @minimum_password_length),
                          input_html: { autocomplete: "new-password" } %>
              <%= f.input :password_confirmation,
                          required: true,
                          input_html: { autocomplete: "new-password" } %>
RUBY
              options[:attributes].each_key do |key|
                view << "\t\t\t\t<%= f.input :#{key} %> \n"
              end
bottom_view=<<RUBY
          </div>

          <div class="form-actions">
            <%= f.button :submit, "Sign up" %>
          </div>
        <% end %>
        
        <%= render "devise/shared/links" %>
RUBY

          view << bottom_view
          view

        end

        def create_views
          
          template "registrations/new.html.erb", "app/views/#{name.pluralize.downcase}/registrations/new.html.erb"
        end

        def create_controllers
          controllers = %w(confirmations passwords registrations sessions unlocks omniauth_callbacks)
          controllers.each do |controller_name|
            template "controllers/#{controller_name}_controller.rb",
                     "app/controllers/#{name.pluralize.downcase}/#{controller_name}_controller.rb"
          end
        end
         


    end
  end
end
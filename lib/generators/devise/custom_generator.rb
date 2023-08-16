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
          if scope
          controllers.each do |name|
            puts name 
            template "controllers/#{name}_controller.rb",
                     "app/controllers/#{scope.pluralize}/#{name}_controller.rb"
            end
          end
        end
        
        def view_template
view=<<RUBY
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
          if scope
          template "registrations/new.html.erb", "app/views/#{scope.pluralize}/registrations/new.html.erb"
          end
        end

      
        
    end
  end
end

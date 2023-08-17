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
          template "model.rb", "app/models/#{scope.downcase}.rb"
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
                     "app/controllers/#{scope.pluralize.downcase}/#{name}_controller.rb"
            end
          end
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
          if scope
          template "registrations/new.html.erb", "app/views/#{scope.pluralize.downcase}/registrations/new.html.erb"
          end
        end
        def migration_data
<<RUBY
        ## Database authenticatable
        t.string :email,              null: false, default: ""
        t.string :encrypted_password, null: false, default: ""
  
        ## Recoverable
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
  
        ## Rememberable
        t.datetime :remember_created_at
  
        ## Trackable
        # t.integer  :sign_in_count, default: 0, null: false
        # t.datetime :current_sign_in_at
        # t.datetime :last_sign_in_at
        # t.string :current_sign_in_ip
        # t.string :last_sign_in_ip
  
        ## Confirmable
        # t.string   :confirmation_token
        # t.datetime :confirmed_at
        # t.datetime :confirmation_sent_at
        # t.string   :unconfirmed_email # Only if using reconfirmable
  
        ## Lockable
        # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
        # t.string   :unlock_token # Only if unlock strategy is :email or :both
        # t.datetime :locked_at
RUBY
        end
          
        def create_migration
          if scope
            template "migration.rb" , "db/migrate/testmigration_devise_create_users.rb"
          end
          #binding.pry
        end

        def copy_routes
          if scope
            template "routes.rb" , "config/routes.rb"
          end
        end
        
    end
  end
end

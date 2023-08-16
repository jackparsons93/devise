# frozen_string_literal: true
<%= table_name=scope.pluralize -%>
class DeviseCreate<%= table_name.camelize %> < ActiveRecord::Migration[7.0]
  def change
    create_table :<%= table_name %> do |t|
<%= migration_data -%>

<% options[:attributes].each do |name, type| -%>
      t.<%= type %> :<%= name %>
<% end -%>

      t.timestamps null: false
    end
    <% table_name=scope.pluralize.to_sym -%>
    add_index :<%= table_name %>, :email,                unique: true
    add_index :<%= table_name %>, :reset_password_token, unique: true
    # add_index :<%= table_name %>, :confirmation_token,   unique: true
    # add_index :<%= table_name %>, :unlock_token,         unique: true
  end
end

# frozen_string_literal: true
require 'pry'
require "test_helper"

class CustomGeneratorTest < Rails::Generators::TestCase
    tests Devise::Generators::CustomGenerator
    destination File.expand_path("../../tmp", __FILE__)
    setup :prepare_destination


    test "Assert parameter is passed" do
        capture(:stderr) { run_generator %w(user) }
        assert_file "app/models/user.rb" do |content|
            assert_match(/User/ , content )
        end
        assert_no_file "app.models/model.rb"

    end

    test "Assert Controllers are created" do
        capture(:stderr) { run_generator %w(user) }
        #assert_file "app/controllers/users/sessions_controller.rb"
        assert_file "app/controllers/users/registrations_controller.rb"
        assert_file "app/controllers/users/confirmations_controller.rb"
        assert_file "app/controllers/users/passwords_controller.rb"
        assert_file "app/controllers/users/unlocks_controller.rb"
        assert_file "app/controllers/users/omniauth_callbacks_controller.rb"
        #binding.pry
    end
    test "Assert Scope is passed to Controllers" do
        capture(:stderr) { run_generator %w(user) }
        assert_file "app/controllers/users/registrations_controller.rb" do |content|
            assert_match(/users/ , content)
        end
    end
    test "Assert Attributes is passed to Controllers" do
        capture(:stderr) { run_generator %w(user -a name:string username:hash) }
        assert_file "app/controllers/users/registrations_controller.rb" do |content|
            assert_match(/username/ , content)
            assert_no_match(/hash/ ,content)
            
        end
    end
    test "Assert views are copied" do
        capture(:stderr) { run_generator %w(user -a name:string phone_number:integer) }
        assert_file "app/views/users/registrations/new.html.erb" do |content|
            assert_match(/f.input/ , content)
            assert_match(/name/ , content)
            assert_match(/phone_number/ , content)
        end
        #binding.pry
    end

    test "Assert migration is copied" do
        capture(:stderr) { run_generator %w(user -a name:string phone_number:integer) }
        assert_file "db/migrate/testmigration_devise_create_users.rb" do |content|
            assert_match(/phone_number/, content)
        end
        #binding.pry
    end
    test "Assert routes.rb is copied" do
        capture(:stderr) { run_generator %w(user -a name:string phone_number:integer) }
        assert_file "config/routes.rb" do |content|
            assert_match(/user/, content)
        end
        binding.pry
    end
end
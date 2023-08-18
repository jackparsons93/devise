require 'pry'
require "test_helper"
class MvcGeneratorTest < Rails::Generators::TestCase
  tests Devise::Generators::MvcGenerator
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination

  test "Assert model is created with monster passed" do
    run_generator %w(monster)
    
    assert_file "app/models/monster.rb"
    
  end
  test "Assert model is created with test passed" do
    run_generator %w(test name:string) 
    assert_file "app/models/test.rb"
    #binding.pry
  end
  test "Assert model is created with attributes is  passed" do
    run_generator %w(test name:string phone_number:integer) 
    binding.pry
    assert_file "app/models/test.rb"
    
  end
end
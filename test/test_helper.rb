#we're telling it what environment we're working in
#we need 3 env's: production, dev, test
#name inside ENV is arbitrary
#ENV is a global varible in command line
#so it's setting
ENV['TASK_MANAGER_ENV'] ||= 'test'
#get access to the config/environment.rb
require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
#ModelTest arbitrary name
class ModelTest < Minitest::Test
  def teardown
    TaskManager.delete_all
  end
end

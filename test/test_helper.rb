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
require 'capybara'
# monkey patching into minitest
class Minitest::Test
  def teardown
    TaskManager.delete_all
  end
end
#only in sinatra, this tells capy to use our app
Capybara.app = TaskManagerApp

#since our model tests don't rely on this, we just include capy in feature tests
class FeatureTest < Minitest::Test
  include Capybara::DSL
end

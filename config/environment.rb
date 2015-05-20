require 'bundler'
Bundler.require
#if not this line then we'd have to say require 'shotgun' etc, and it's for every file in the project
# set the pathname for the root of the app
# Rackup is the config.ru

require 'pathname'
#pathname part of R std lib so not gem but need to require
#take current file go up 2 levels, and connect to current file
#and make a Pathname object instead of just a string
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# require the controller(s)
# join with the root file, app, controllers and anything ending in rb
# putting dir makes these files an array
# and for each file require that file
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }

# require the model(s)
Dir[APP_ROOT.join('app', 'models', '*.rb')].each { |file| require file }

# configure TaskManagerApp settings
# this is monkey patching and you can do this anywhere
#to_path creates a string
#root had to be defined first to use it
class TaskManagerApp < Sinatra::Base
  set :method_override, true
  set :root, APP_ROOT.to_path
  set :views, File.join(TaskManagerApp.root, "app", "views")
  set :public_folder, File.join(TaskManagerApp.root, "app", "public")
end

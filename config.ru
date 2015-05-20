#require 'bundler'
#Bundler.require

#$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/app"))
#File.dirname(__FILE__) is the current directory which is TaskManager and adds /app
#then File.expand_path will give you the absolute path of it
#this adds to the load_path array, the expanded file path
#require 'controllers/task_manager_app'
#require goes off loadpath unlike require_relative
#don't use require_relative because if you change things it'll be messy

#run TaskManagerApp
#require 'bundler'
#Bundler.require
#:: unscopes from a module if nothing's in front of it, you can remove them
#if for some reason you're in a module, and you want to use a scoped method you would need to say asdfsd::File
#don't have to put .rb at end of environment because .ru is a ruby file
require ::File.expand_path('../config/environment',  __FILE__)

run TaskManagerApp

require 'bundler'
Bundler.require

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/app"))
#File.dirname(__FILE__) is the current directory which is TaskManager and adds /app
#then File.expand_path will give you the absolute path of it
#this adds to the load_path array, the expanded file path
require 'controllers/task_manager_app'
#require goes off loadpath unlike require_relative
#don't use require_relative because if you change things it'll be messy

run TaskManagerApp

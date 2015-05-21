
class TaskManager
  def self.database
    if ENV["TASK_MANAGER_ENV"] == "test"
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager.sqlite3")
    end
  end

  def self.create(task)
    database.from(:tasks).insert(:title => task['title'],
                             :description => task['description'])

    #no error because sequel has method transaction
    #where do we create the table? through migrations
    #migration starts with number001 because the order in which it's run
    #is very important
    #no need for id because it will be created in our table
    #now run the migration file
    #we need to require sequel in that file, and also do TaskManager.database
    #still it doesn't see the table because the test needs a table in the test database
    #in terminal you can set TASK_MANAGER_ENV=test then ruby and filepath/name
    #so there's problem with teardown method, just comment it out on the test_helper
    #problem with the find method so change it to filter database
    # with sequel the doesn't reset the id's so set the id in the test
    #
    #database.transaction do
      #database['tasks'] ||= []
      #database['total'] ||= 0
      #database['total'] += 1
      #database['tasks'] << { "id" => database['total'],
                             #"title" => task['title'],
                             #"description" => task['description'] }
    #end

  end

  def self.raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def self.all
    database.from(:tasks).map do |data|
      Task.new(data)
    end
    #tasks.map do |data|
      #Task.new(data)
    #end
  end

  def self.raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def self.find(id)
    task = database.from(:tasks).where(:id => id)
    Task.new(task.to_a.first)
    #Task.new(task)
    #Task.new(raw_task(id))
  end

  def self.update(id, data)
    dataset.where(id: id).update(data)
    #database.transaction do
      #target = database['tasks'].find { |task| task["id"] == id }
      #target["title"] = data["title"]
      #target["description"] = data["description"]
    #end
  end

  def self.destroy(id)
    database.from(:tasks).where(:id => id).delete
    #database.transaction do
      #database['tasks'].delete_if { |task| task["id"] == id }
    #end
  end

  def self.delete_all
    database.from(:tasks).delete
    #database.transaction do
      #database['tasks'] = []
      #database['total'] = 0
    #end
  end

  private

  def self.dataset
    database.from(:tasks)
  end
end

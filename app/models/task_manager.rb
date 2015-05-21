class TaskManager
  def self.database
    if ENV["TASK_MANAGER_ENV"] == "test"
      @database ||= Sequel.sqlite("db/task_manager_test.sqlite3")
    else
      @database ||= Sequel.sqlite("db/task_manager.sqlite3")
    end
  end

  def self.create(task)
    dataset.insert(task)
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
  end

  def self.raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def self.all
    dataset.map do |data|
      Task.new(data)
    end
  end

  def self.raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def self.find(id)
    task = dataset.where(:id => id)
    Task.new(task.to_a.first)
  end

  def self.update(id, data)
    dataset.where(id: id).update(data)
  end

  def self.destroy(id)
    dataset.where(:id => id).delete
  end

  def self.delete_all
    dataset.delete
  end

  private

  def self.dataset
    database.from(:tasks)
  end
end

require_relative '../test_helper'

class TaskManagerTest < ModelTest
  def create_tasks(num)
  end
  def test_can_create_a_task
    #we're using symbols because
    data = { "title" => "learn sinatra", "description" => "seriously." }

    TaskManager.create(data)
    #since create doesn't return a task, we'll use our custom find
    task = TaskManager.find(1)

    assert_equal "learn sinatra", task.title
    assert_equal "seriously.", task.description
    assert_equal 1, task.id
  end

  def test_can_find_all_tasks
    data1 = { "title" => "learn sinatra", "description" => "seriously." }
    data2 = { "title" => "learn rails", "description" => "for reals." }

    TaskManager.create(data1)
    TaskManager.create(data2)

    assert_equal 2, TaskManager.all.count
  end

  def test_it_can_find_a_task
    data1 = { "title" => "learn sinatra", "description" => "seriously." }
    data2 = { "title" => "learn rails", "description" => "for reals." }

    TaskManager.create(data1)
    TaskManager.create(data2)
    task2 = TaskManager.find(2)

    assert_equal "learn rails", task2.title
  end

  def test_it_can_update_a_task
    data1 = { "title" => "learn sinatra", "description" => "seriously." }
    data2 = { :title => "learn rails", :description => "for reals." }

    TaskManager.create(data1)
    TaskManager.update(1, data2)
    task = TaskManager.find(1)

    assert_equal "learn rails", task.title
  end

  def test_it_can_destroy_a_task
    data1 = { "title" => "learn sinatra", "description" => "seriously." }
    data2 = { "title" => "learn rails", "description" => "for reals." }

    TaskManager.create(data1)
    TaskManager.create(data2)
    TaskManager.destroy(1)

    assert_equal 1, TaskManager.all.count
    assert_equal "learn rails", TaskManager.all.first.title

    TaskManager.destroy(2)

    assert_equal 0, TaskManager.all.count
  end
end

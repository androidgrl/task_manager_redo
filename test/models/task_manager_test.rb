require_relative '../test_helper'

class TaskManagerTest < Minitest::Test

  def create_tasks(num)
    num.times do |num|
      data = { "title" => "title#{num}", "description" => "description#{num}"}
      TaskManager.create(data)
    end
  end

  def test_can_create_a_task
    create_tasks(1)
    last_id = TaskManager.all.last.id
    task = TaskManager.find(last_id)

    assert_equal last_id, task.id
    #assert_equal 1, task.id
    assert_equal "title0", task.title
    assert_equal "description0", task.description
  end

  def test_can_find_all_tasks
    create_tasks(3)

    assert_equal 3, TaskManager.all.count
    assert_equal ["title0", "title1", "title2"], TaskManager.all.map(&:title)
  end

  def test_it_can_find_a_task
    create_tasks(3)

    task2 = TaskManager.find(2)

    assert_equal "title1", task2.title
  end

  def test_it_can_update_a_task
    data1 = { "title" => "learn sinatra", "description" => "seriously." }
    data2 = { "title" => "learn rails", "description" => "for reals." }

    TaskManager.create(data1)
    TaskManager.update(1, data2)
    task = TaskManager.find(1)

    assert_equal "learn rails", task.title
  end

  def test_it_can_destroy_a_task
    create_tasks(5)

    assert_equal 5, TaskManager.all.count
    last_id = TaskManager.all.last.id

    TaskManager.destroy(last_id)
    assert_equal 4, TaskManager.all.count
    #assert_equal "title1", TaskManager.all.first.title

    #TaskManager.destroy(last_id)
    #assert_equal 3, TaskManager.all.count
  end
end

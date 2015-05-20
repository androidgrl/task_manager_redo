require_relative '../test_helper'

class TaskTest < ModelTest
  def test_assigns_attributes_correctly
    data = { "title"       => "a title",
             "description" => "a description",
             "id"          => 1 }

    task = Task.new(data)

    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

end

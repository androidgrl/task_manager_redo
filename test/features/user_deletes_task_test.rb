require_relative "../test_helper"

class UserDeletesTaskTest < FeatureTest
  def test_user_deletes_a_task
    TaskManager.create("title" => "Learn ios", "description" => "Today")
    visit '/tasks'
    within("#tasks") do
      assert page.has_content?("Learn ios")
    end
    click_button("Delete")
    within("#tasks") do
      refute page.has_content?("Learn ios")
    end
  end
end

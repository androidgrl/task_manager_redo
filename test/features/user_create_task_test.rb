require_relative "../test_helper"

class UserCreateTaskTest < FeatureTest
  def test_the_user_can_create_a_task
    visit '/'
    click_link "New Task"
    assert_equal "/tasks/new", current_path
    within("#new") do
      assert page.has_content?("Enter a new task:")
    end
    fill_in("task[title]", :with => "Get hired by Occipital")
    fill_in("task[description]", :with => "Learn ios, and pass the interview")
    click_button "submit"
    assert_equal "/tasks", current_path
    within("#tasks") do
      assert page.has_content?("Get hired by Occipital")
    end
  end
end

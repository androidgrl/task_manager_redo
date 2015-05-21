require_relative "../test_helper"

class UserEditsTaskTest < FeatureTest
  def test_the_user_edits_task
    TaskManager.create("title" => "Learn ios", "description" => "now")
    visit "/tasks"
    within("#tasks") do
      assert page.has_content?("Learn ios")
    end
    click_link("Edit")

    last_id = TaskManager.all.last.id


    assert_equal "/tasks/#{last_id}/edit", current_path
    fill_in("task[title]", :with => "Learn android")
    fill_in("task[description]", :with => "Make MM App")
    click_button("Submit")
    assert_equal "/tasks/#{last_id}", current_path
    within("#show") do
      assert page.has_content?("Learn android")
      refute page.has_content?("Learn ios")
    end
  end
end

require_relative '../test_helper'

class UserEditsTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_user_can_edit_a_task
    data1 = {
      title:       "some title",
      description: "some description"
    }
    task_manager.create(data1)

    visit '/'

    click_link("Task Index")

    assert_equal '/tasks', current_path

    click_link("Edit")

    assert_equal '/tasks/1/edit', current_path

    fill_in 'task[title]', with: 'Updated Title'
    fill_in 'task[description]', with: 'Updated Description'

    click_button('submit')

    assert_equal '/tasks', current_path

    within 'h3' do
      assert page.has_content? 'Updated Title'
    end

    visit '/tasks/1'

    within 'h1' do
      assert page.has_content? 'Updated Title'
    end
    within 'p' do
      assert page.has_content? 'Updated Description'
    end
  end
end

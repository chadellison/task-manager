require_relative '../test_helper'

class HomePageGreetingTest < Minitest::Test
  include Capybara::DSL

  def test_home_page_welcomes_user
    visit '/'
    within("#greeting") do
      assert page.has_content?("Welcome to the Task Manager")
    end
  end
end

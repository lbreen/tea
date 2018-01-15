require "application_system_test_case"

class GroupsTest < ApplicationSystemTestCase
  test "lets a signed in user create a new group" do
    login_as users(:luke)

    visit 'groups/new'

    fill_in "group_name", with: "GroveStreetGangsters"
    fill_in "group_colour", with: "Red"
    click_on 'Create Group'

    # Should be redirected to Home with new product
    assert_equal group_index, page.current_path
  end
end

require 'test_helper'

class GroupMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get group_members_new_url
    assert_response :success
  end

  test "should get create" do
    get group_members_create_url
    assert_response :success
  end

  test "should get destroy" do
    get group_members_destroy_url
    assert_response :success
  end

end

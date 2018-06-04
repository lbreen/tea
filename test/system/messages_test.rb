require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  test "broadcast on messages" do
    visit messages_url

    assert_selector "h1", text: "Message"
  end
end

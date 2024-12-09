require "test_helper"

class Api::V1::AssistantAiControllerTest < ActionDispatch::IntegrationTest
  test "should get ask" do
    get api_v1_assistant_ai_ask_url
    assert_response :success
  end
end

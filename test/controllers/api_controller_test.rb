require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get newmessage" do
    get :newmessage
    assert_response :success
  end

end

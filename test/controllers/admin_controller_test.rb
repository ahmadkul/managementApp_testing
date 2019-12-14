require 'test_helper'
include Devise::TestHelpers

class AdminControllerTest < ActionController::TestCase

  def setup
    @user = FactoryBot.build(:user, email: 'test@mail.com')
  end

  test "should get home" do
    sign_in @user
    get :home
    assert_response :success
  end
end

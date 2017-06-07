require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
  end

  test "should show correct user" do
    get user_path(@user.nickname)
    assert_template 'users/show'
    assert_select 'div.user-info div.user__name', { count: 1, text: @user.name }
  end

  test "should show logout path when logged in" do
    #log_in_as(@user)
    #get user_path(@user.nickname)
    #assert_template 'users/show'
    #assert_select 'a[href=?]', logout_path
  end
end

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:lethieu)
  end

  test "should show correct user when user exists" do
    get user_path(@user.nickname)
    assert_template 'users/show'
    assert_select 'div.profile div.user__name', { count: 1, text: @user.name }
  end

  test "should show error page when user does not exist" do
    assert_raise ActiveRecord::RecordNotFound do
      get user_path('not_existed_user')
    end
  end
end

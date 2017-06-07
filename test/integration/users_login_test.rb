require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    OmniAuth.config.test_mode = true
  end

  test "login with twitter fail" do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    assert_no_difference 'User.count' do
      get twitter_login_path
      follow_redirect!  # redirected to /auth/twitter/callback
    end
    follow_redirect!  # redirected to /auth/failure then automatically to root
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', twitter_login_path
  end

  test "login with twitter successfully" do
    # Log in
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: '12345',
      info: {
        name: 'User',
        nickname: 'user',
        image: 'http://example.com/avatar.jpg'
      }
    })
    assert_difference 'User.count', 1 do
      get twitter_login_path
      follow_redirect!  # redirected to /auth/twitter/callback
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', user_path('user')
    assert_select 'a[href=?]', twitter_login_path, count: 0
    # To user's page
    get user_path('user')
    assert_select 'a[href=?]', user_path('user'), count: 1
    assert_select 'a[href=?]', logout_path
    # To other user's page
    get user_path(users(:lethieu).nickname)
    assert_select 'a[href=?]', user_path('user'), count: 1
    assert_select 'a[href=?]', logout_path, count: 0
    # Log out
    delete logout_path
    assert session[:user_id].nil?
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', twitter_login_path
    assert_select 'a[href=?]', user_path('user'), count: 0
  end

  def teardown
    OmniAuth.config.mock_auth[:twitter] = nil
    OmniAuth.config.test_mode = false
  end
end

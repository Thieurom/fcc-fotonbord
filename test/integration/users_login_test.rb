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
    # Log out
    delete logout_path
    assert session[:user_id].nil?
    assert_redirected_to root_url
    follow_redirect!
    assert_select 'a[href=?]', twitter_login_path
    assert_select 'a[href=?]', user_path('user'), count: 0
  end

  test "create new foton" do
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
    get twitter_login_path
    follow_redirect!  # redirected to /auth/twitter/callback
    follow_redirect!
    # Create new foton
    # Post invalid
    assert_no_difference 'Foton.count' do
      post fotons_path, xhr: true, params: { foton: { source: '', caption: '' } }
    end
    assert_response :unprocessable_entity
    assert_select '.form__error'
    # Post valid
    source = "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_120x44dp.png"
    caption = "Google Logo" 
    assert_difference 'Foton.count', 1 do
      post fotons_path, xhr: true, params: { foton: { source: source, caption: caption } }
    end
    assert_response :created

    # Link a foton
    @foton = fotons(:foton_1)
    assert_difference 'BordenFoton.count', 1 do
      patch foton_path(@foton)
    end
    assert_response :ok

    # Unlink a foton
    @foton = fotons(:foton_1)
    assert_difference 'BordenFoton.count', -1 do
      delete foton_path(@foton)
    end
    assert_response :no_content
  end

  def teardown
    OmniAuth.config.mock_auth[:twitter] = nil
    OmniAuth.config.test_mode = false
  end
end

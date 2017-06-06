require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    OmniAuth.config.test_mode = true
  end

  test "login with twitter fail" do
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
    assert_no_difference 'User.count' do
      get '/auth/twitter'
      follow_redirect!
    end
  end

  test "login with twitter successfully" do
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: '123456',
      info: {
        name: 'thieu'
      }
    })
    assert_difference 'User.count', 1 do
      get '/auth/twitter'
      follow_redirect!
    end
  end

  def teardown
    OmniAuth.config.mock_auth[:twitter] = nil
    OmniAuth.config.test_mode = false
  end
end

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  test "should redirect like if not logged in" do
    foton = Foton.first;
    assert_no_difference 'Like.count' do
      post like_path(foton.id)
    end
    assert_redirected_to root_url
  end

  test "should redirect unlike if not logged in" do
    foton = Foton.first;
    assert_no_difference 'Like.count' do
      post unlike_path(foton.id)
    end
    assert_redirected_to root_url
  end
end

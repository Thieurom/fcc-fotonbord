require 'test_helper'

class FotonsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @fotons = Foton.all
  end

  test "show all fotons" do
    get root_url
    assert_select 'div.foton', count: @fotons.count
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Foton.count' do
      post fotons_path, params: { source: "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_120x44dp.png", caption: "Google Logo" }
    end
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    @foton = fotons(:foton_1)
    assert_no_difference 'BordenFoton.count' do
      patch foton_path(@foton)
    end
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    @foton = fotons(:foton_1)
    assert_no_difference 'BordenFoton.count' do
      delete foton_path(@foton)
    end
    assert_redirected_to root_url
  end
end

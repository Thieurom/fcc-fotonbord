require 'test_helper'

class FotonTest < ActiveSupport::TestCase

  def setup
    @user = users(:lethieu)
    @foton = @user.fotons.build(source: "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_120x44dp.png", caption: "Google Logo")
  end

  test "foton instance should be valid" do
    assert @foton.valid?
  end

  test "source should be present" do
    @foton.source = "   "
    assert_not @foton.valid?
  end

  test "caption should be present" do
    @foton.caption = "   "
    assert_not @foton.valid?
  end

  test "caption should be at most 140 characters" do
    @foton.caption = "a" * 141
    assert_not @foton.valid?
  end

  test "source should be an valid image" do
    @foton.source = "http://foo.com/foton.jpg"
    assert_not @foton.valid?
  end
end

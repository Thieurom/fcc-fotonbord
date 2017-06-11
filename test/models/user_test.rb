require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should be valid" do
    @user = User.new(provider: "twitter", uid: "123456")
    assert @user.valid?
  end

  test "provider should not be null" do
    @user = User.new(uid: "123456")
    begin
      @user.save
    rescue
      assert_not @user.persisted?
    end
  end

  test "uid should not be null" do
    @user = User.new(provider: "twitter")
    begin
      @user.save
    rescue
      assert_not @user.persisted?
    end
  end

  test "associated fotons should be destroyed" do
    @user = User.create(provider: "twitter", uid: "54321")
    @user.fotons.create(source: "https://www.google.com.vn/images/branding/googlelogo/2x/googlelogo_color_120x44dp.png", caption: "Google Logo")
    assert_difference 'Foton.count', -1 do
      @user.fotons.delete(@user.fotons.first)
    end
  end
end

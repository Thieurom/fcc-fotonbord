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
end

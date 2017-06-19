require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @user = users(:lethieu)
    @foton = fotons(:most_recent)
    @like = @foton.likes.build(user_id: @user.id, foton_id: @foton.id)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "foton id should be present" do
    @like.foton_id = nil
    assert_not @like.valid?
  end

  test "user id should be present" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "should be unique" do
    like_again = @like.dup
    @like.save
    assert_not like_again.valid?
  end

  test "associated like should be destroyed" do
    @like.save
    assert_difference 'Like.count', -1 do
      @foton.destroy
    end
  end
end

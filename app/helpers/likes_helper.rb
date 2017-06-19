module LikesHelper

  def liked_by?(likes, user)
    likes.each do |like|
      if like.user_id == user.id
        return true
      end
    end
    return false
  end
end

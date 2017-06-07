class User < ApplicationRecord

  def self.from_auth(auth_hash)
    User.find_or_create_by(provider: auth_hash.provider, uid: auth_hash.uid) do |user|
      user.name = auth_hash.info.name
      user.nickname = auth_hash.info.nickname
      user.image_url = auth_hash.info.image
    end
  end
end

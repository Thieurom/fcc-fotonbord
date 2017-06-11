class User < ApplicationRecord
  has_many :borden_fotons
  has_many :fotons, through: :borden_fotons, after_remove: :check_orphan

  def self.from_auth(auth_hash)
    User.find_or_create_by(provider: auth_hash.provider, uid: auth_hash.uid) do |user|
      user.name = auth_hash.info.name
      user.nickname = auth_hash.info.nickname
      user.image_url = auth_hash.info.image
    end
  end

  private
  def check_orphan(foton)
    if foton.users.empty?
      foton.destroy
    end
  end
end

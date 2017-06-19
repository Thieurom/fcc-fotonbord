class Like < ApplicationRecord
  belongs_to :foton
  validates :user_id, presence: true
  validates :foton_id, presence: true, uniqueness: { scope: :user_id }
end

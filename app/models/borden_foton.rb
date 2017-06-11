class BordenFoton < ApplicationRecord
  default_scope -> { order('created_at DESC') }
  belongs_to :user
  belongs_to :foton
end

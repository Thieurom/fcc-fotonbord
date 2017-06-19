class SourceValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    begin
      response = HTTParty.head(value)
      unless response.code == 200 && response.headers['content-type'].start_with?('image')
        record.errors[attribute] << "is not a valid image" 
      end
    rescue
      record.errors[attribute] << "is not a valid URL" 
    end
  end
end


class Foton < ApplicationRecord
  default_scope -> { order('created_at DESC') }
  has_many :borden_fotons
  has_many :users, through: :borden_fotons
  has_many :likes, dependent: :destroy
  validates :source, presence: true, source: true
  validates :caption, presence: true, length: { maximum: 140 }
end

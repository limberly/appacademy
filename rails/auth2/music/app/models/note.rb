class Note < ApplicationRecord
  validates :content, :user_id, :track_id, presence: true


  belongs_to :user
  belongs_to :track
end

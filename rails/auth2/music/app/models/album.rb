class Album < ApplicationRecord
  ALBUM_TYPES = ["live", "studio"]
  
  validates :title, :year, presence: true
  validates :album_type, inclusion: {in: ALBUM_TYPES}

  belongs_to :band
  has_many :tracks, dependent: :destroy
end

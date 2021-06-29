class Track < ApplicationRecord
  TRACK_TYPES = ['regular', 'bonus']

  HUMANIZED_ATTRIBUTES = {
    ord: "Track number"
  }

  validates :title, :album_id, presence: true
  validates :ord, presence: true
  validates :track_type, presence: true, inclusion: {in: TRACK_TYPES}

  belongs_to :album
  has_many :notes, dependent: :destroy
end

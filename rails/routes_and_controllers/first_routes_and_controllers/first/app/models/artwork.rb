class Artwork < ApplicationRecord
  validates :artist_id, presence: true
  validates :title, uniqueness: {scope: :artist_id, message: "Artist cannot have artworks with a same name"}
  
  belongs_to :artist,
    class_name: :User,
    foreign_key: :artist_id,
    primary_key: :id

  has_many :artwork_shares
  has_many :shared_viewers,
    through: :artwork_shares,
    source: :viewer

  has_many :comments, dependent: :destroy
end
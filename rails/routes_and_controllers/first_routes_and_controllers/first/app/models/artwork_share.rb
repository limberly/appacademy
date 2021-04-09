class ArtworkShare < ApplicationRecord
  validates :artwork_id, uniqueness: {scope: :viewer_id, message: "already shared"}

  belongs_to :viewer, class_name: :User
  belongs_to :artwork
end
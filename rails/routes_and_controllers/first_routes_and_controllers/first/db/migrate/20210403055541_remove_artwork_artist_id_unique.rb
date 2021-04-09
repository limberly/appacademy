class RemoveArtworkArtistIdUnique < ActiveRecord::Migration[6.1]
  def change
    remove_index :artworks, :artist_id
    add_index :artworks, :artist_id
  end
end

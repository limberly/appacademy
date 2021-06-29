class AddAlbumIdToTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :tracks, :album_id, :integer, null: false
  end
end

class AddIndexToAlbums < ActiveRecord::Migration[6.1]
  def change
    add_index :albums, :title
  end
end

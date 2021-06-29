class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.string :title, null: false
      t.integer :ord, null: false
      t.text :lyrics, null: true
      t.string :track_type, null: false
      t.timestamps
    end

    add_index :tracks, :title
  end
end

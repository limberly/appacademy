class CreateHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :houses do |t|
      t.text :address, null: false
      t.timestamps
    end
  end
end

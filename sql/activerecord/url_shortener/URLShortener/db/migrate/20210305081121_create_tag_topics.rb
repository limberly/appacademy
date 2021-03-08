class CreateTagTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_topics do |t|
      t.string :tag
      t.string :short_url
      
      t.timestamps
    end
  end
end

class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :title
      t.text :description
      t.string :picture
      t.string :category
      t.integer :user_id
      
      t.integer :num_votes
      t.integer :raw_score
      t.decimal :score
      
      t.integer :pic_id
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end

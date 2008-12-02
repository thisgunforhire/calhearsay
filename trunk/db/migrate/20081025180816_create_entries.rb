class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :title
      t.string :rating
      t.text :description
      t.string :picture
      t.string :category
      t.string :state
      t.integer :user_id
      
      t.string :addr
      t.string :zip
      
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

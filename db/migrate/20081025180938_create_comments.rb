class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :comment
      t.integer :entry_id
      t.integer :user_id
      t.string :anon
      
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

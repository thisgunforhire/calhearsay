class CreateUserpics < ActiveRecord::Migration
  def self.up
    create_table :userpics do |t|
      t.column :user_id,  :integer
      t.column :content_type, :string
      t.column :filename, :string    
      t.column :thumbnail, :string 
      t.column :size, :integer
      t.column :width, :integer
      t.column :height, :integer
    end
  end

  def self.down
    drop_table :userpics
  end
end

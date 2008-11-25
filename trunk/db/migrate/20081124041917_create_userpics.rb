class CreateUserpics < ActiveRecord::Migration
  def self.up
    create_table :userpics do |t|
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :userpics
  end
end

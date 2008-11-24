class CreateUserpics < ActiveRecord::Migration
  def self.up
    create_table :userpics do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :userpics
  end
end

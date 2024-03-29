class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default =>'', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      
      t.integer :age
      t.string :dob
      t.text :interests
      t.text :about_me
      t.string :aim
      t.string :website
      
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :userpic_id,    :integer
      t.integer :entry_count
      t.integer :comment_count
      

    end
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table "users"
  end
end

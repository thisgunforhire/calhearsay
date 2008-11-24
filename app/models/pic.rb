class Pic < ActiveRecord::Base
 
  belongs_to:entry
  validates_presence_of :entry
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :processor => 'Rmagick',
                 :max_size => 6.megabytes,                 
                 :resize_to => '400x400>',                 
                 :thumbnails => { :thumb => '150x150>' }
                

 # validates_as_attachment

end

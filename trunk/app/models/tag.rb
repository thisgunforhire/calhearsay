class Tag < ActiveRecord::Base
  belongs_to:entry
  belongs_to:user
  
  validates_presence_of :tag
  validates_presence_of :user
  validates_presence_of :entry
end

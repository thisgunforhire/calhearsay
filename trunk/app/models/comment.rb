class Comment < ActiveRecord::Base
  belongs_to:entry
  belongs_to:user
  
  validates_presence_of :comment
  validates_presence_of :user
  validates_presence_of :entry
end

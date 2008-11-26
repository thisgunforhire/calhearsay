class Entry < ActiveRecord::Base
  has_one:pic
  has_many:comments
  has_many:tags
  belongs_to:user

  acts_as_rateable
  
  #validations
  validates_presence_of :user
  validates_presence_of :title
  validates_length_of :title, :maximum => 100, :if => Proc.new{|x| !(x.title.blank?)}
  validates_presence_of :description
  validates_length_of :description, :maximum => 500, :if => Proc.new{|x| !(x.description.blank?)}
  #validates_format_of :picture, :with => %r{jpg|gif|jpeg|png}i, :message => "must be a URL for a GIF, JPG, or PNG image"
  validates_presence_of :category, :message => "must be selected."
  #validates_format_of :category, :with =>%r{hos|bums}i, :message => "Must be either ho's or bums"
  
end

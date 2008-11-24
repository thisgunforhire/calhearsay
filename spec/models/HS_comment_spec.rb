require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Comment do
  fixtures :entries, :comments, :users
  
  before(:each) do
    @valid_attributes = {
      :entry => entries(:one),
      :comment => "value for comment",
      :user => users(:quentin),
      :anony => true
    }
  end

  it "should create a new instance given valid attributes" do
    Comment.create!(@valid_attributes)
  end
  
  it "should belong to a comment" do
    comment = Comment.find(1)
    comment.entry.should_not be_nil
  end
  describe "has the following fields and" do
    def create_comment(attributes, remove = nil)
      if remove
         attributes = attributes.dup
         attributes.delete(remove)
       end
      Comment.new(attributes)
    end
    
    it "should have an entry" do
      entry = create_comment(@valid_attributes, :entry)
      entry.should_not be_valid
      entry.errors.on(:entry).should == 'can\'t be blank'      
    end
    
    it "should have a user" do
      entry = create_comment(@valid_attributes, :user)
      entry.should_not be_valid
      entry.errors.on(:user).should == 'can\'t be blank'      
    end
    
    it "should have a comment" do
      entry = create_comment(@valid_attributes, :comment)
      entry.should_not be_valid
      entry.errors.on(:comment).should == 'can\'t be blank'      
    end
  end
end

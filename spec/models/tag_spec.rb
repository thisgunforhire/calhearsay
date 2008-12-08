require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tag do
  fixtures :entries, :tags, :users
  
  before(:each) do
    @valid_attributes = {
      :entry => entries(:one),
      :tag => "value for tag",
      :user => users(:quentin)
      }
  end

  it "should create a new instance given valid attributes" do
    Tag.create!(@valid_attributes)
  end
  
  describe "has the following fields and" do
    def create_tag(attributes, remove = nil)
      if remove
         attributes = attributes.dup
         attributes.delete(remove)
       end
      Tag.new(attributes)
    end
    
    it "should have a tag" do
      entry = create_tag(@valid_attributes, :tag)
      entry.should_not be_valid
      entry.errors.on(:tag).should == 'can\'t be blank'      
    end
  end
end

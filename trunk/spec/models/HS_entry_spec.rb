require File.dirname(__FILE__) + '/../spec_helper'

describe Entry do
  fixtures :entries, :comments, :users
  
  before(:each) do
    @valid_attributes = {
      :user => users(:quentin),
      :title => "Title",
      :description => "Description",
      :photo => pic.file
      :entry_datetime => Time.now,
      :anony => true
    }
    @entry = Entry.new(@valid_attributes)
  end

  it "should be valid" do
    @entry.should be_valid
  end

  it "should have comments" do
    entry = Entry.find(1)
    entry.should_not be_nil
    
    entry.comments.should have(2).records
  end
  
  describe "has the following fields and" do
    def create_entry(attributes, remove = nil)
      if remove
         attributes = attributes.dup
         attributes.delete(remove)
       end
      Entry.new(attributes)
    end
    
    it "should have a title" do
      entry = create_entry(@valid_attributes, :title)
      entry.should_not be_valid
      entry.errors.on(:title).should == 'can\'t be blank'
    end
    
    it "should have a valid title" do
      entry = create_entry(@valid_attributes.merge(:title => 'a' * 101))
      entry.should_not be_valid
      entry.errors.on(:title).should == 'is too long (maximum is 100 characters)'
      entry.title = 'a' * 100
      entry.should be_valid      
    end
    
    it "should have a description" do
      entry = create_entry(@valid_attributes, :description)
      entry.should_not be_valid
      entry.errors.on(:description).should == 'can\'t be blank'
    end
    
    it "should have a valid description" do
      entry = create_entry(@valid_attributes.merge(:description => 'a' * 501))
      entry.should_not be_valid
      entry.errors.on(:description).should == 'is too long (maximum is 500 characters)'
      entry.description = 'a' * 500
      entry.should be_valid      
    end
    
    it "should have a user" do
      entry = create_entry(@valid_attributes, :user)
      entry.should_not be_valid
      entry.errors.on(:user).should == 'can\'t be blank'      
    end
  end
end

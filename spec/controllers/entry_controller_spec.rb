require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EntriesController do
  fixtures :users
  #Delete this example and add some real ones
  it "should use EntryController" do
    controller.should be_an_instance_of(EntryController)
  end
  
  def mock_entry(stubs={})
    @mock_entry ||= mock_model(Entry, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all entries as @entries" do
      Entry.should_receive(:find).with(:all).and_return([mock_entry])
      get :index
      assigns[:entries].should == [mock_entry]
    end

  end

  describe "responding to GET show" do

    it "should expose the requested entry as @entry" do
      Entry.should_receive(:find).with("37").and_return(mock_entry)
      get :show, :id => "37"
      assigns[:entry].should equal(mock_entry)
    end
    
  end

  describe "responding to GET new" do
    it "should expose a new entry as @entry" do
      login_as(:quentin)
      Entry.should_receive(:new).and_return(mock_entry)
      get :new
      assigns[:entry].should equal(mock_entry)
    end
    
    it "should not be allowed if not logged in" do
      get :new
      response.should redirect_to(new_session_url)
    end
  end

  describe "responding to GET edit" do
    it "should expose the requested entry as @entry" do
      login_as(:quentin)
      Entry.should_receive(:find).with("37").and_return(mock_entry(:user_id => users(:quentin).id))
      get :edit, :id => "37"
      assigns[:entry].should equal(mock_entry)
    end
    
    it "should not be allowed if not logged in" do
      get :edit, :id => "37"
      response.should redirect_to(new_session_url)
    end
    
  end

end

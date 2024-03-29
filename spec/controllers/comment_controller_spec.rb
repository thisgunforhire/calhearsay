# rcov does not like the login_as method; however, this is necessary for our rspecs to pass. a user must be logged in.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  fixtures :users

  def mock_comment(stubs={})
    @mock_comment ||= mock_model(Comment, stubs)
  end
  
  def mock_entry(stubs={})
    @mock_entry ||= mock_model(Entry, stubs)
  end


  #Delete this example and add some real ones
  it "should use CommentsController" do
    controller.should be_an_instance_of(CommentsController)
  end
  
  describe "responding to GET new" do
    it "should expose a new comment as @comment when logged in" do
      login_as(:quentin)
      Comment.should_receive(:new).and_return(mock_comment)
      #mock_comment.should_receive(:entry)
      Entry.should_receive(:find).with("31").and_return(mock_entry)
      get :new, :entry_id => "31"
      assigns[:comment].should equal(mock_comment)
    end

    it "should not be allowed if not logged in" do
      get :new, :entry_id => "31"
      response.should redirect_to(new_session_url)
    end
  end

end

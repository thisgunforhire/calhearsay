require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommentsController do
  fixtures :users

  def mock_comment(stubs={})
    @mock_comment ||= mock_model(Comment, stubs)
  end
  
  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs)
  end


  #Delete this example and add some real ones
  it "should use CommentsController" do
    controller.should be_an_instance_of(CommentsController)
  end
  
  describe "responding to GET new" do
    it "should expose a new comment as @comment when logged in" do
      login_as(:quentin)
      Comment.should_receive(:new).and_return(mock_comment)
      Event.should_receive(:find).with("31").and_return(mock_event)
      get :new, :event_id => "31"
      assigns[:comment].should equal(mock_comment)
    end

    it "should not be allowed if not logged in" do
      get :new, :event_id => "31"
      response.should redirect_to(new_session_url)
    end
  end

end

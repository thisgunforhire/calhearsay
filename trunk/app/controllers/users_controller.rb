class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  

  # render new.rhtml
  def new
    @user = User.new
     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
   # @user.userpic = Userpic.new(:uploaded_data => params[:user_pic])
    
    
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/entries/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact the webmaster."
      render :action => 'new'
    end
  end
end

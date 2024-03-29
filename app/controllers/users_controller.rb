class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  #def pageSelect    
  #  if params[:pageType] == ""
  #    render :partial => "users/empty"
  #  else
  #    render :partial => params[:pageType]
  #  end
  #end
  
  def show
    #@entries = Entry.find(:all)
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

 # render new.rhtml
  def new
    @user = User.new
     respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
     end
  end
 
  # GET /entries/1/edit
  def edit
    @user ||= User.find(params[:id])
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @user ||= User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.userpic = Userpic.new(:uploaded_data => params[:user_pic])
    @user.entry_count = 0
    @user.comment_count = 0
    
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/entries/')#change this line to redirect to user edit instead of entries :-)
      flash[:notice] = "Thanks for signing up! Edit your profile to personalize your account"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact the webmaster."
      render :action => 'new'
    end
  end
end

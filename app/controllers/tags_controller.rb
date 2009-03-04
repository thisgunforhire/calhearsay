class TagsController < ApplicationController
  before_filter :login_required, :only=> [:destroy, :update, :edit, :create, :new, :show, :index]
  #before_filter :check_user, :only => [:destroy, :update, :edit]
  # GET /tags
  # GET /tags.xml
  def index
    @entry = Entry.find(params[:entry_id])
	  @tags = @entry.tags
    #@tag.entry = @entry
    #@tag.user = current_user
   
	  respond_to do |format|
    #  format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end
  
  def entrySearch    
    session[:query] = params[:query].strip if params[:query]
    
    if session[:query] and request.xhr?
      @articles1 = Entry.find(:all, :conditions => ["title LIKE ?", "%#{session[:query]}%"])
      @articles2 = Tag.find(:all, :conditions => ["tag LIKE ?", "%#{session[:query]}%"])     
      #render :partial => "tags/searchresults", :layout => false, :locals => {:searchresults => @articles2}
      render :partial => "tags/entryresults", :layout => false, :locals => {:searchresults => @articles1, :searchresults2 => @articles2} 
    end
  end


  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = Tag.find(params[:id])
	  @entry = Entry.find(params[:entry_id])
    @user = @tag.user
    #@search = Tag.find(:first, :conditions => ["tag => ?", :query])
    #@tag.entry = @entry
    #@tag.user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = Tag.new
	  @entry = Entry.find(params[:entry_id])
    #@tag.entry = @entry
    #@tag.user = current_user
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag ||= Tag.find(params[:id])
	  @entry = Entry.find(params[:entry_id])
    #@tag.entry = @entry
    #@tag.user = current_user
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])
	  @entry = Entry.find(params[:entry_id])
	  @tag.entry = @entry
    @tag.user = current_user
	
    respond_to do |format|
      if @tag.save
        flash[:notice] = 'Tag was successfully created.'
        format.html { redirect_to(@entry) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag ||= Tag.find(params[:id])
	  @entry = Entry.find(params[:entry_id])
   
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Tag was successfully updated.'
        format.html { redirect_to(@entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag ||= Tag.find(params[:id])
    @tag.destroy
	  @entry = Entry.find(params[:entry_id])
   
    respond_to do |format|
      format.html { redirect_to(@entry) }
      format.xml  { head :ok }
    end
  end
  
  def access_denied
        if logged_in?
          render :text => "You have insufficient permissions", :status => 401
          return false
        else
          super
        end
  end
  
  def check_user
        @tag = Tag.find(params[:id])
        unless @tag.user_id == current_user.id
          access_denied
        end
  end
end
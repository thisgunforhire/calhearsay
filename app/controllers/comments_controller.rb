class CommentsController < ApplicationController
  before_filter :login_required, :only=> [:destroy, :update, :edit, :create, :new, :show, :index]
  #before_filter :check_user, :only => [:destroy, :update, :edit]
  # GET /comments
  # GET /comments.xml
  def index
    @entry = Entry.find(params[:entry_id])
	  @comments = @entry.comments
    #@comment.entry = @entry
    #@comment.user = current_user
   
	  respond_to do |format|
    #  format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])
	  @entry = Entry.find(params[:entry_id])
    @user = @comment.user
    #@comment.entry = @entry
    #@comment.user = current_user

    respond_to do |format|
    #  format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
	  @entry = Entry.find(params[:entry_id])
    #@comment.entry = @entry
    #@comment.user = current_user
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment ||= Comment.find(params[:id])
	  @entry = Entry.find(params[:entry_id])
    #@comment.entry = @entry
    #@comment.user = current_user
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
	  @entry = Entry.find(params[:entry_id])
	  @comment.entry = @entry
    @comment.user = current_user
	
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@entry) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment ||= Comment.find(params[:id])
	  @entry = Entry.find(params[:entry_id])
   
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment ||= Comment.find(params[:id])
    @comment.destroy
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
        @comment = Comment.find(params[:id])
        unless @comment.user_id == current_user.id
          access_denied
        end
  end
end

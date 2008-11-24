class EntriesController < ApplicationController
  before_filter :login_required, :only=> [:destroy, :update, :edit, :create, :new, :show, :index]
  #before_filter :check_user, :only => [:destroy, :update, :edit]
  # GET /entries
  # GET /entries.xml
  def index
    @entries = Entry.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id])
    @comments = @entry.comments
    
    @user ||= @entry.user
	  
    @pic = @entry.pic
    #@pic = Pic.find(params[@entry.pic_id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new
    
   
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry ||= Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    @entry.user = current_user
    @entry.num_votes = 0
    @entry.raw_score = 0
        
    @entry.pic = Pic.new(:uploaded_data => params[:entry_pic])
    
    respond_to do |format|
      if @entry.save
        flash[:notice] = 'Entry was successfully created.'
        format.html { redirect_to(@entry) }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry ||= Entry.find(params[:id])
    @entry.user = current_user

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to(@entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry ||= Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
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
        @entry = Entry.find(params[:id])
        unless @entry.user_id == current_user.id
          access_denied
        end
  end
  
  def add_vote(new_vote)
    self.raw_score += new_vote
    self.num_votes += 1  
    self.score = (self.raw_score * 1.0) / (self.num_votes)
  
  end
  
end
class UserpicsController < ApplicationController

  def index
    @userpics = Userpic.find(:all)
  end
  
def new
  @userpic = Userpic.new
end

def create
  @userpic = Userpic.new(params[:pic])
  
  @user.userpic = Userpic.new(:uploaded_data => params[:user_pic])
  
  if @userpic.save
    flash[:notice] = 'Pic was successfully created.'
    redirect_to pic_url(@userpic)     
  else
    render :action => :new
  end
end

def show
    @Userpic = Userpic.find(params[:id])
end


end
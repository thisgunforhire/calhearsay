class UserpicsController < ApplicationController

  def index
    @userpics = Userpic.find(:all)
  end
  
def new
  @userpic = Userpic.new
end

def create
  @userpic = Userpic.new(params[:userpic])
  if @userpic.save
    flash[:notice] = 'Userpic was successfully created.'
    redirect_to userpic_url(@userpic)     
  else
    render :action => :new
  end
end

def show
    @userpic = Userpic.find(params[:id])
end


end
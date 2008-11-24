class PicsController < ApplicationController

  def index
    @pics = Pic.find(:all)
  end
  
def new
  @pic = Pic.new
end

def create
  @pic = Pic.new(params[:pic])
  if @pic.save
    flash[:notice] = 'Pic was successfully created.'
    redirect_to pic_url(@pic)     
  else
    render :action => :new
  end
end

def show
    @pic = Pic.find(params[:id])
end


end
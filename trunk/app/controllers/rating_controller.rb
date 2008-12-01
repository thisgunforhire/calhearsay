class RatingController < ApplicationController
  
  def rate
    @entry = Entry.find(params[:id])
    Rating.delete_all(["rateable_type = 'Entry' AND rateable_id = ? AND user_id = ?", 
      @entry.id, current_user.id])
    @entry.add_rating Rating.new(:rating => params[:rating], 
      :user_id => current_user.id)
  
  render :update do |page|
    page["star-ratings-block"].replace_html :partial => "rating/rate", :locals => { :entry => @entry }
  #  replace_html "star-ratings-block", :partial => "rating/rate", :locals => { :entry => @entry }
    
    end
  
  
  end

end

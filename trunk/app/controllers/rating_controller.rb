class RatingController < ApplicationController
  
  def rate
    @entry = Entry.find(params[:id])
    Rating.delete_all(["rateable_type = 'Entry' AND rateable_id = ? AND user_id = ?", 
      @entry.id, current_user.id])
    @entry.add_rating Rating.new(:rating => params[:rating], 
      :user_id => current_user.id)
  end

end

module EntriesHelper
  def get_user(user_id)
    User.find(user_id)
  end
end

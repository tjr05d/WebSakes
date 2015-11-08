module UsersHelper

  def randomize_users
    User.where.not(id: current_user.id).shuffle
  end


end

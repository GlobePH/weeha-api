class UsersController < ApplicationController

  def index
    users = User.where.not(id: current_user.id).where(verified: true)

    render json: users, status: 200
  end

end

class Users::RegistrationsController < ApplicationController

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: 200
    else
      render json: { errors: user.errors.full_message }, status: 422
    end
  end

  def confirm
    user = User.find_by(username: params[:username]).confirm(params[:users][:confirmation_code])

    if user
      render json: user, status: 200
    else
      render json: { errors: user.errors.full_message }, status: 422
    end
  end

private

  def user_params
    params.require(:users).permit(:mobile_number, :username, :first_name, :last_name)
  end

end

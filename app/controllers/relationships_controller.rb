class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    follow = current_user.follow(user)

    if follow.persisted?
      render json: follow, status: 200
    else
      render json: { errors: follow.errors.full_message }, status: 422
    end
  end

  def approve
    relationship = current_user.pending_requests.find(params[:id])

    if relationship.update(status: 'approved')
      render json: relationship, status: 200
    else
      render json: { errors: relationship.errors.full_message }, status: 422
    end
  end

  def destroy
    relationship = current_user.passive_relationships.find(params[:id])
    relationship.destroy

    render json: { message: 'Successfully deleted' }, code: 422
  end

end

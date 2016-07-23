class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:followed_id])
    follow = current_user.follow(user)

    if follow.persisted?
      render json: follow, status: 200
    else
      render json: { errors: follow.errors.full_messages.to_sentence }, status: 422
    end
  end

  def approve
    relationship = current_user.pending_requests.find(params[:id])

    if relationship.update(status: 'approved')
      render json: relationship, status: 200
    else
      render json: { errors: relationship.errors.full_messages.to_sentence }, status: 422
    end
  end

  def destroy
    relationship = current_user.passive_relationships.find(params[:id])
    relationship.destroy

    render json: { message: 'Successfully deleted' }, code: 422
  end

  def pending_requests
    relationships = current_user.pending_requests

    render json: relationships, include: 'follower', status: 200
  end

  def approved_requests
    relationships = current_user.approved_requests

    render json: relationships, include: 'follower', status: 200
  end

  def following
    following = current_user.active_relationships.where(status: 'approved')

    render json: following, include: { followed: { include: 'locations' } }, status: 200
  end

  def follower
    follower = current_user.passive_relationships.where(status: 'approved')

    render json: follower, include: 'follower', status: 200
  end

end

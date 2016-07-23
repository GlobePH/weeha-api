class LocationsController < ApplicationController

  def index
    locations = current_user.locations

    render json: locations, status: 200
  end

  def create
    location = current_user.locations.new(location_params)

    if location.save
      render json: location, status: 200
    else
      render json: { errors: location.errors.full_messages.to_sentence }, status: 422
    end
  end

  def last
    location = current_user.locations.last

    render json: location, status: 200
  end

private

  def location_params
    params.require(:locations).permit(:lat, :lng)
  end

end

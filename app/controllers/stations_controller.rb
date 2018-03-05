class StationsController < ApplicationController
  include StationsHelper

  def index
    create_stations if stations_need_create_or_update?
    update_available_bikes if bixis_need_update?
    @stations_with_bixis = Station.where("available_bixis > 0").order(:distance_from_office).limit(5)
    if @stations_with_bixis.empty?
      @message = "Sorry, there's no available bixis nearby. Here is a list of the closest stations:"
      @closest_stations = Station.order(:distance_from_office).limit(5)
    end
  end

  def create
    redirect_to root_path
  end
end

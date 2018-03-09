class StationsController < ApplicationController
  include StationsHelper

  def index
    set_stations_variables
  end

  def create
    update_available_bikes
    set_stations_variables
  end

  private

  def set_stations_variables
    @stations_with_bixis = Station.where("available_bixis > 0").order(:distance_from_office).limit(5)
    @closest_stations = Station.order(:distance_from_office).limit(5) if @stations_with_bixis.empty?
  end

end

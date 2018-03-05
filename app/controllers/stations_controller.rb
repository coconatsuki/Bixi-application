class StationsController < ApplicationController
  include StationsHelper

  def index
    create_stations if stations_need_create_or_update?
    update_available_bikes if bixis_need_update?
    set_stations_variables
  end

  def create
    set_stations_variables
  end

  private

  def set_stations_variables
    @stations_with_bixis = Station.where("available_bixis > 0").order(:distance_from_office).limit(5)
    @closest_stations = Station.order(:distance_from_office).limit(5) if @stations_with_bixis.empty?
  end

end

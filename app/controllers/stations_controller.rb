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
end

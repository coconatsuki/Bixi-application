class UpdateStationsJob < ApplicationJob
  queue_as :default
  include StationsHelper

  def perform
    create_stations
  end
end

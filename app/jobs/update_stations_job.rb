class UpdateStationsJob < ApplicationJob
  queue_as :default
  include StationsHelper

  def perform
    if stations_need_create_or_update?
      create_stations
    else
      Rails.logger.info("Stations already up to date")
    end
  end
end

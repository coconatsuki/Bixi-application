class UpdateBixisAvailabilityJob < ApplicationJob
  queue_as :default
  include StationsHelper

  def perform
    create_stations if Station.count == 0
    if bixis_need_update?
      update_available_bikes
    else
      Rails.logger.info("Stations already up to date")
    end
  end
end

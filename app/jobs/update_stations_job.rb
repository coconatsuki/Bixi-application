class UpdateStationsJob < ApplicationJob
  queue_as :default

  rescue_from Interactor::Failure do
    Rails.logger.info("Stations already up to date")
  end

  def perform
    UpdateStationsList.call
  end
end

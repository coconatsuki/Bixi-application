class UpdateBixisAvailabilityJob < ApplicationJob
  queue_as :default

  rescue_from Interactor::Failure do
    Rails.logger.info("Bixis already up to date")
  end

  def perform
    UpdateBixisInfos
    end
end

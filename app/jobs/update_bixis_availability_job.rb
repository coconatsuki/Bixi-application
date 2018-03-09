class UpdateBixisAvailabilityJob < ApplicationJob
  queue_as :default
  include StationsHelper

  def perform
    update_available_bikes
  end
end

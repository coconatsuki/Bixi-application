class UpdateAvailableBikes
  include Interactor

  def call
    api_stations = BixisService.request_bikes
    api_stations.each do |station|
      Station.where(bixi_id: station['station_id']).update_all(available_bixis: station['num_bikes_available'])
    end
    BixisRequestDate.value = Time.now
  end
end

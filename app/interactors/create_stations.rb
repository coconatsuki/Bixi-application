class CreateStations
  include Interactor

  def call
    stations_array = BixisService.request_stations
    stations_array.each do |station|
      unless Station.find_by(bixi_id: station['station_id'])
        new_station = Station.create(
          bixi_id: station['station_id'],
          name: station['name'],
          latitude: station['lat'],
          longitude: station['lon'],
        )
        new_station.distance_from_office = new_station.distance_from([45.506318, -73.569021], :km)
        new_station.save
      end
    end
    StationsRequestDate.value = Time.now
    context.stations_array = stations_array
  end

end

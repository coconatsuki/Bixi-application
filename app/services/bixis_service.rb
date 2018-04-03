class BixisService

  def self.request_stations
    stations_list = RestClient.get 'https://api-core.bixi.com/gbfs/en/station_information.json'
    JSON.parse(stations_list.body)['data']['stations']
  end

  def self.request_bikes
    bikes = RestClient.get 'https://api-core.bixi.com/gbfs/en/station_status.json'
    JSON.parse(bikes.body)['data']['stations']
  end

end

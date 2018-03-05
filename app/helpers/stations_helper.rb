module StationsHelper
  require 'rest-client'

# Fetch the datas from the API

  def request_stations
    stations_list = RestClient.get 'https://api-core.bixi.com/gbfs/en/station_information.json'
    JSON.parse(stations_list.body)["data"]["stations"]
  end

  def request_bikes
    bikes = RestClient.get 'https://api-core.bixi.com/gbfs/en/station_status.json'
    JSON.parse(bikes.body)["data"]["stations"]
  end

  # Update the date of each API request in the RequestDate database.

  def create_and_update_request_time(request)
    RequestDate.find_or_create_by(request_name: request).update(date: Time.now)
  end

  def stations_need_create_or_update?
    request = RequestDate.find_by(request_name: "request_stations")
    !request || request.date < 1.day.ago
  end

  def bixis_need_update?
    request = RequestDate.find_by(request_name: "request_bikes")
    !request || request.date < 1.minute.ago
  end

# Creates & updates stations in the Database, and destroy useless ones

  def create_stations
    stations_array = request_stations
    stations_array.each do |station|
      if !Station.find_by(bixi_id: station["station_id"])
        new_station = Station.create(
          bixi_id: station["station_id"],
          name: station["name"],
          latitude: station["lat"],
          longitude: station["lon"],
        )
        new_station.distance_from_office = new_station.distance_from([45.506318, -73.569021], :km)
        new_station.save
      end
    end
    create_and_update_request_time("request_stations")
    destroy_useless_stations(stations_array)
  end

  def destroy_useless_stations(stations_array)
    stations_id_list = stations_array.map { |station| station["station_id"] }
    Station.where.not(bixi_id: stations_id_list).destroy_all
  end

  # Update each station's available bikes

  def update_available_bikes
    api_stations = request_bikes
    api_stations.each do |station|
      Station.where(bixi_id: station["station_id"]).update_all(available_bixis: station["num_bikes_available"])
    end
    create_and_update_request_time("request_bikes")
  end
end

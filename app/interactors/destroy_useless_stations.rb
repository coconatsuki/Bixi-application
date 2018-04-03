class DestroyUselessStations
  include Interactor

  def call
    stations_id_list = context.stations_array.map { |station| station['station_id'] }
    Station.where.not(bixi_id: stations_id_list).destroy_all
  end
end

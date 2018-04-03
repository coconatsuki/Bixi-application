class UpdateStationsList
  include Interactor::Organizer

  organize StationsNeedCreateOrUpdate, CreateStations, DestroyUselessStations
end

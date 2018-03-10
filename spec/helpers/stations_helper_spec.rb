require 'rails_helper'

RSpec.describe StationsHelper, vcr: { :record => :new_episodes }, type: :helper do
  after(:each) do
    StationsHelper::STATIONS_REQUEST_DATE.delete
    StationsHelper::BIXIS_REQUEST_DATE.delete
  end

  describe '#request_stations' do
    it 'returns an array of hashes' do
      expect(helper.request_stations).to be_kind_of(Array)
    end
    it 'includes stations with a name' do
      expect(helper.request_stations.first['name']).to be_kind_of(String)
    end
  end

  describe '#request_bikes' do
    it 'returns an array of hashes' do
      expect(helper.request_bikes).to be_kind_of(Array)
    end
    it 'gives available bikes for each station' do
      expect(helper.request_bikes.first['num_bikes_available']).to be_kind_of(Integer)
    end
  end

  describe '#stations_need_create_or_update?' do
    it 'returns true if no api request has been made yet' do
      expect(stations_need_create_or_update?).to be_truthy
    end
    it 'returns true if the request is more than 1 day old' do
      StationsHelper::STATIONS_REQUEST_DATE.value = 2.days.ago
      expect(stations_need_create_or_update?).to be_truthy
    end
    it 'returns false if the request is less than 1 day old' do
      StationsHelper::STATIONS_REQUEST_DATE.value = 2.hours.ago
      expect(stations_need_create_or_update?).to be_falsy
    end
  end

  describe '#bixis_need_update?' do
    it 'returns true if no api request has been made yet' do
      expect(stations_need_create_or_update?).to be_truthy
    end
    it 'returns true if the request is more than 2 minutes old' do
      StationsHelper::BIXIS_REQUEST_DATE.value = 5.minutes.ago
      expect(bixis_need_update?).to be_truthy
    end
    it 'returns false if the request is less than 1 minute old' do
      StationsHelper::BIXIS_REQUEST_DATE.value = 30.seconds.ago
      expect(bixis_need_update?).to be_falsy
    end
  end

  describe '#create_stations' do
    let(:first_station) { Station.first }
    subject do
      helper.create_stations
    end
    it 'adds stations in the database' do
      subject
      expect(first_station.name).not_to be_nil
      expect(first_station.latitude).not_to be_nil
      expect(first_station.longitude).not_to be_nil
      expect(Station.count).to be > 10
    end
    it 'calculates distances and create adresses' do
      subject
      expect(first_station.distance_from_office).to be_kind_of(Float)
      expect(first_station.distance_from_office).to be > 0
      expect(first_station.address).to eq('New York, NY, USA')
    end
    it 'destroys useless stations in the database' do
      useless_database_station = create(:station, bixi_id: "abcd")
      fake_api_station = [{ "name" => "unknown-station", "bixi_id" => 2}]
      expect(Station.count).to eq(1)
      subject
      expect( Station.find_by("bixi_id" => "abcd")).to be_nil
    end
    it 'updates the api request date (for stations)' do
      expect { subject }.to change { StationsHelper::STATIONS_REQUEST_DATE.value }.from(nil)
    end
  end

  describe '#update_available_bikes' do
    subject do
      helper.create_stations
      helper.update_available_bikes
    end
    it 'updates the number of available bixis for each station' do
      subject
      expect(Station.first.available_bixis).to be_truthy
    end
    it 'update the api request date (for bikes)' do
      expect { subject }.to change { StationsHelper::BIXIS_REQUEST_DATE.value }.from(nil)
    end
  end
end

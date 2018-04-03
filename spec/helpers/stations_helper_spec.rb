require 'rails_helper'

RSpec.describe StationsHelper, vcr: { :record => :new_episodes }, type: :helper do
  after(:each) do
    StationsRequestDate.delete
    BixisRequestDate.delete
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
      expect { subject }.to change { StationsRequestDate.value }.from(nil)
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
      expect { subject }.to change { BixisRequestDate.value }.from(nil)
    end
  end
end

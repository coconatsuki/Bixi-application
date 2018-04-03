describe CreateStations, vcr: { record: :new_episodes } do
  after(:each) do
    StationsRequestDate.delete
  end
  let(:first_station) { Station.first }
  subject do
    CreateStations.call
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
  it 'updates the api request date (for stations)' do
    expect { subject }.to change { StationsRequestDate.value }.from(nil)
  end
end

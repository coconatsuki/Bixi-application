describe DestroyUselessStations, vcr: { record: :new_episodes } do
  subject do
    DestroyUselessStations.call(stations_array: [{ "name" => "unknown-station", "bixi_id" => 2 }])
  end
  let(:first_station) { Station.first }

  it 'destroys useless stations in the database' do
    create(:station, bixi_id: "abcd")
    expect(Station.count).to eq(1)
    subject
    expect( Station.find_by("bixi_id" => "abcd")).to be_nil
  end
end

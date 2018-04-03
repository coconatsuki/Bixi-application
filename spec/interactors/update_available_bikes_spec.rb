describe UpdateAvailableBikes, vcr: { record: :new_episodes } do
  after(:each) do
    BixisRequestDate.delete
  end
  subject do
    CreateStations.call
    UpdateAvailableBikes.call
  end

  it 'updates the number of available bixis for each station' do
    subject
    expect(Station.first.available_bixis).to be_truthy
  end
  it 'update the api request date (for bikes)' do
    expect { subject }.to change { BixisRequestDate.value }.from(nil)
  end
end

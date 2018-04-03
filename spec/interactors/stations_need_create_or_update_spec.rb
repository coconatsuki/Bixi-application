describe StationsNeedCreateOrUpdate do

after(:each) do
  StationsRequestDate.delete
end

subject do
  StationsNeedCreateOrUpdate.call
end

  it 'returns true if no api request has been made yet' do
    expect(subject.success?).to be_truthy
  end
  it 'returns true if the request is more than 1 day old' do
    StationsRequestDate.value = 2.days.ago
    expect(subject.success?).to be_truthy
  end
  it 'returns false if the request is less than 1 day old' do
    StationsRequestDate.value = 2.hours.ago
    expect(subject.success?).to be_falsy
  end
end

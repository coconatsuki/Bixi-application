describe BixisNeedUpdate do
  after(:each) do
    BixisRequestDate.delete
  end

  subject do
    BixisNeedUpdate.call
  end

  it 'returns true if no api request has been made yet' do
    expect(subject.success?).to be_truthy
  end
  it 'returns true if the request is more than 2 minutes old' do
    BixisRequestDate.value = 5.minutes.ago
    expect(subject.success?).to be_truthy
  end
  it 'returns false if the request is less than 1 minute old' do
    BixisRequestDate.value = 30.seconds.ago
    expect(subject.success?).to be_falsy
  end
end

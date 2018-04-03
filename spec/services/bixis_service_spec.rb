describe BixisService, vcr: { :record => :new_episodes } do
  describe '#request_stations' do
    it 'returns an array of hashes' do
      expect(BixisService.request_stations).to be_kind_of(Array)
    end
    it 'includes stations with a name' do
      expect(BixisService.request_stations.first['name']).to be_kind_of(String)
    end
  end

  describe '#request_bikes' do
    it 'returns an array of hashes' do
      expect(BixisService.request_bikes).to be_kind_of(Array)
    end
    it 'gives available bikes for each station' do
      expect(BixisService.request_bikes.first['num_bikes_available']).to be_kind_of(Integer)
    end
  end
end

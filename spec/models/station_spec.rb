require 'rails_helper'

RSpec.describe Station, type: :model do
  it { should validate_presence_of(:bixi_id) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
end

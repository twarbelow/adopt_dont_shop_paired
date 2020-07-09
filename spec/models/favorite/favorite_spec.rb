require 'rails_helper'

RSpec.describe Favorite do
  describe '#count' do
    it 'has a count' do
      favorite = Favorite.new

      expect(favorite.count).to eq(0)
    end
  end
end

require 'rails_helper'

RSpec.describe Favorites do
  describe '#count' do
    it 'has a count' do
      favorites = Favorites.new

      expect(favorites.count).to eq(0)
    end
  end
end

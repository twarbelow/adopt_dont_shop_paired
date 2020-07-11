require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I have not added any pets to my favorites list' do
    describe "And I visit my favorites page ('/favorites')" do
      it 'I see text saying that I have no favorited pets' do
        visit '/favorites'

        expect(page).to have_content("You have not favorited any pets")
      end
    end
  end
end 

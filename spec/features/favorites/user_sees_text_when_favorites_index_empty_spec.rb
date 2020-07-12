require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe 'When I have not added any pets to my favorites list' do
    describe "And I visit my favorites page ('/favorites')" do
      it 'I see text saying that I have no favorited pets' do
        visit '/favorites'

        expect(page).to have_content("You currently have no pets favorited! Visit a pet's page and favorite it to see it listed here.")
      end
    end
  end
end

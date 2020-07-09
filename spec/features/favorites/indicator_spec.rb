require 'rails_helper'

RSpec.describe 'Favorites Indicator' do
  describe 'is in the nav bar' do
    it 'on every page' do
      shelter = Shelter.create(name:            "Good Boys Are Us",
                                 address:       "1234 ABC Street",
                                 city:          "Denver",
                                 state:         "Colorado",
                                 zip:           80202)

      pet = Pet.create(image:                  "https://cdn0.wideopenpets.com/wp-content/uploads/2019/03/Untitled-design-2019-03-27T180734.510-770x405.jpg",
                          name:                 "Sokka",
                          approximate_age:      3.0,
                          sex:                  "Male",
                          shelter_id:           shelter.id)

      visit "/"
      save_and_open_page
      expect(page).to have_content("Favorites")

      visit "/shelters/#{shelter.id}"
      expect(page).to have_content("Favorites")

      visit "/pets/#{pet.id}"
      expect(page).to have_content("Favorites")
    end

    # it 'shows a count of favorites' do
    #   visit "/"
    #   expect(page).to have_content("Favorites: 0")
    # end
  end
end

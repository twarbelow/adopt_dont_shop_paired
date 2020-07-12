require 'rails_helper'

RSpec.describe 'Favorites Indicator' do
  describe 'is in the nav bar' do
    it 'on every page showing a count of favorites' do
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
      expect(page).to have_content("Favorites: 0")

      visit "/shelters/#{shelter.id}"
      expect(page).to have_content("Favorites: 0")

      visit "/pets/#{pet.id}"
      expect(page).to have_content("Favorites: 0")
    end
  end
end

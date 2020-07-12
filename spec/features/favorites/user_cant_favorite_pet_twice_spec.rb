require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create!(name:         "Good Boys Are Us",
                                 address:      "1234 ABC Street",
                                 city:         "Denver",
                                 state:        "Colorado",
                                 zip:          80202)

    @pet_1 = Pet.create!(image:                "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
                         name:                 "Samson",
                         approximate_age:      4.5,
                         sex:                  "Male",
                         shelter_id:           @shelter_1.id)


    @pet_2 = Pet.create!(image:                "https://i.pinimg.com/736x/3f/47/7f/3f477ff92627ba171fcc867f23285cf5.jpg",
                         name:                 "Delilah",
                         approximate_age:      4.0,
                         sex:                  "Female",
                         shelter_id:           @shelter_1.id)

  end

  describe "Once a pet has been favorited" do
    describe "When I visit that pet's show page" do
      it "removes the link to favorite a pet once it has already been favorited" do

        visit "/pets/#{@pet_1.id}"

        click_on('Favorite This Pet')

        expect(page).not_to have_link('Favorite This Pet')
        expect(page).to have_link('Remove From Favorites')
      end
    end

    describe "When I click that link" do
      it "removes pet from favorites, user is redirected to pet's page,
          user sees flash message, link to favorites returns,
          and see indicator decrement" do

        visit "/pets/#{@pet_1.id}"

        click_on('Favorite This Pet')

        expect(page).to have_content('Favorites: 1')

        click_on('Remove From Favorites')

        expect(current_path).to eq("/pets/#{@pet_1.id}")
        expect(page).to have_content("Pet has been removed from your favorites")
        expect(page).to have_content("Favorites: 0")
        expect(page).to have_link('Favorite This Pet')
        expect(page).not_to have_link('Remove From Favorites')
      end
    end
  end
end

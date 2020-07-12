require 'rails_helper'

RSpec.describe 'Remove a favorite pet from index process', type: :feature do
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

    visit "/pets/#{@pet_1.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_2.id}"
    click_on('Favorite This Pet')

    visit '/favorites'
  end

  describe "Once a pet has been favorited" do
    describe "When I visit favorites index page" do
      it 'next to each pet, I see a button or link to remove that pet from my favorites' do

        within "#favorite-#{@pet_1.id}" do
          expect(page).to have_link("Remove From Favorites", href: "/favorites/#{@pet_1.id}")
        end

        within "#favorite-#{@pet_2.id}" do
          expect(page).to have_link("Remove From Favorites", href: "/favorites/#{@pet_2.id}")
        end
      end
    end
  end

  describe 'When I click on that button or link to remove a favorite' do
    it "removes pet from favorites, user is redirected to favorites index and indicator decremented" do
      expect(page).to have_content("Favorites: 2")

      within "#favorite-#{@pet_1.id}" do
        click_on("Remove From Favorites")
      end

      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Pet has been removed from your favorites")
      expect(page).not_to have_css("#favorite-#{@pet_1.id}")
      expect(page).not_to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
      expect(page).to have_content("Favorites: 1")
    end
  end
end

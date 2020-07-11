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
  end

  describe "When I have added pets to my favorites list" do
    describe "And I visit my favorites page ('/favorites')" do
      it "I see a link to remove all favorited pets" do
        visit '/favorites'
        expect(page).to have_link('Remove All Favorited Pets')
      end
    end

    describe "When I click link to remove all favorite pets" do
      it "I'm redirected back to the favorites page, see no favorites message, and indicator is 0" do
        visit '/favorites'
        click_on('Remove All Favorited Pets')

        expect(current_path).to eq('/favorites')
        expect(page).to have_content("All pets have been removed from your favorites list")
        expect(page).to have_content("You have not favorited any pets")
        expect(page).to have_content("Favorites: 0")#favorites counter
      end
    end
  end
end

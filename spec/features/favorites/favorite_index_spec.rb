require 'rails_helper'

RSpec.describe 'Favorite index page', type: :feature do
  describe 'without favorites' do
    it "shows text indicating no favorites when there are none" do
      visit '/favorites'
      save_and_open_page
      expect(page).to have_content("You currently have no pets favorited! Visit a pet's page and favorite it to see it listed here.")
    end
  end
  describe 'with favorites' do
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

    it 'shows when the favorites indicator is clicked' do
      find('#fav-pets').click
      expect(current_path).to eq '/favorites'
    end

    describe "After favoriting pets and visiting favorite index page" do
      it "can display the linked name of all pets I've favorited" do
        visit '/favorites'
        within "#favorite-#{@pet_1.id}" do
          expect(page).to have_link(@pet_1.name, href: "/pets/#{@pet_1.id}")
        end

        within "#favorite-#{@pet_2.id}" do
          expect(page).to have_link(@pet_2.name, href: "/pets/#{@pet_2.id}")
        end
      end

      it "can display the image of all pets I've favorited" do
        visit '/favorites'

        within "#favorite-#{@pet_1.id}" do
          expect(page).to have_css("img[src*='#{@pet_1.image}']")
        end

        within "#favorite-#{@pet_2.id}" do
          expect(page).to have_css("img[src*='#{@pet_2.image}']")
        end
      end
    end
  end
end

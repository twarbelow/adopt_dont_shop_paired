require 'rails_helper'

RSpec.describe 'Favorite index page', type: :feature do
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

  describe "After favoriting pets and visiting favorite index page" do
    it "can display the linked name of all pets I've favorited" do
      visit '/favorites'

      within "#favorite-#{@pet_1.id}" do
        expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
      end

      within "#favorite-#{@pet_2.id}" do
        expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
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
      expect(page).to have_content()# enter favorites counter here

      within "#favorite-#{@pet_1.id}" do
        click_on("Remove From Favorites")
      end

      expect(current_path).to eq("/favorites")
      expect(page).to have_content()# enter flash message here
      expect(page).not_to have_css("#favorite-#{@pet_1.id}")
      expect(page).not_to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
      expect(page).to have_content()# enter favorites counter here
    end
  end

  describe 'When I have not added any pets to my favorites list' do
    describe "And I visit my favorites page ('/favorites')" do
      it 'I see text saying that I have no favorited pets' do
        visit '/favorites'

        expect(page).to have_content("You have not favorited any pets")
      end
    end
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
        expect(page).to have_content("You have removed all pets from your favorites list. ╥﹏╥")
        expect(page).to have_content("You have not favorited any pets. Visit pet pages and click 'Favorite This Pet' to add them here!")
        expect(page).to have_content('Favorites (0)')
      end
    end
  end
end

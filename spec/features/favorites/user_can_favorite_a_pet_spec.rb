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

  describe "When a user visits a pet's show page" do
   it 'allows user to see a button or link to favorite that pet' do
     visit "/pets/#{@pet_1.id}"

     expect(page).to have_link('Favorite This Pet')
   end
 end

 describe 'When a user clicks the button or link' do
   it "takes the user to that pet's show page, user sees a flash message, and the indicator is incremented by one" do
     visit "/pets/#{@pet_1.id}"

     expect(page).not_to have_content("Pet has been added to your favorites list")
     expect(page).to have_content("Favorites (0)")

     click_on('Favorite This Pet')

     expect(current_path).to eq("/pets/#{@pet_1.id}")
     expect(page).to have_content("Pet has been added to your favorites list")
     expect(page).to have_content("Favorites (1)")

     visit "/pets/#{@pet_2.id}"

     expect(page).not_to have_content("Pet has been added to your favorites list")
     expect(page).to have_content("Favorites (1)")

     click_on('Favorite This Pet')

     expect(current_path).to eq("/pets/#{@pet_2.id}")
     expect(page).to have_content("Pet has been added to your favorites list")
     expect(page).to have_content("Favorites (2)")
   end
 end
end










  visit "/pets/#{@pet_1.id}"
  click_on('Favorite This Pet')
  visit "/pets/#{@pet_2.id}"
  click_on('Favorite This Pet')

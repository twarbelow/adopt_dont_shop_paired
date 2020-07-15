require 'rails_helper'

RSpec.describe 'pet application' do
  before(:each) do
    @shelter_1 = Shelter.create!(name:          "Good Boys Are Us",
                                 address:       "1234 ABC Street",
                                 city:          "Denver",
                                 state:         "Colorado",
                                 zip:           80202)

    @pet_1 = Pet.create!(image:                 "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
                         name:                  "Samson",
                         approximate_age:       4.5,
                         sex:                   "Male",
                         shelter_id:            @shelter_1.id)

    @pet_2 = Pet.create!(image:                 "https://i.pinimg.com/736x/3f/47/7f/3f477ff92627ba171fcc867f23285cf5.jpg",
                         name:                  "Delilah",
                         approximate_age:       4.0,
                         sex:                   "Female",
                         shelter_id:            @shelter_1.id)

    @pet_3 = Pet.create!(image:                 "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.com%2FDahey-Hedgehog-Plastic-Decoration-Hamster%2Fdp%2FB06XK495CL&psig=AOvVaw3V-7f11Pm7eVMSar5TYz_p&ust=1594750899460000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICq95nsyuoCFQAAAAAdAAAAABAD",
                          name:                 "Schnooper",
                          approximate_age:      13.0,
                          sex:                  "Male",
                          shelter_id:           @shelter_1.id)

    visit "/pets/#{@pet_1.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_2.id}"
    click_on('Favorite This Pet')
  end

  describe "When a user has added pets to favorites list" do
    describe "And a user visits favorites page" do
      it "allows user to click link Apply to Adopt and take them to a new application form" do
        visit "/favorites"
        click_link("Apply to Adopt")

        expect(current_path).to eq("/favorites/application")
      end

      it "can select from the favorited pets for which user would like application to apply towards" do
        visit "/favorites/application"

        expect(page).to have_css("#pet_ids_[value='#{@pet_1.id}']")
        expect(page).to have_css("#pet_ids_[value='#{@pet_2.id}']")
        expect(page).to_not have_css("#pet_ids_[value='#{@pet_3.id}']")
      end

      describe "When a user selects one or more pets, and fills in info, and clicks sumbit" do
        it "Returns user to favorites page, user sees a flash message, and no longer sees the pets user applied for" do
          visit "/favorites/application"

          find("#pet_ids_[value='#{@pet_1.id}']")

          fill_in :name, with: "CatLady"
          fill_in :address, with: "4939 Ithaca Dr"
          fill_in :city, with: "Fairbanks"
          fill_in :state, with: "Alaska"
          fill_in :zip, with: "99709"
          fill_in :phone_number, with: "907-474-4929"
          fill_in :description, with: "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."

          click_button 'Submit Application'

          expect(current_path).to eq("/favorites")
          expect(page).to have_content("Your application for the selected pet has been submitted.")

          expect(page).not_to have_css("favorite-#{@pet_1.name}")
          expect(page).to have_content(@pet_2.name)
        end
      end
    end
  end
end

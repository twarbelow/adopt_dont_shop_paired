require 'rails_helper'

RSpec.describe "Pet update process", type: :feature do
  before(:each) do

    @shelter_1 = Shelter.create!(name:         "Good Boys Are Us",
                                address:       "1234 ABC Street",
                                city:          "Denver",
                                state:         "Colorado",
                                zip:           80202)

    @pet_3 = Pet.create!(image:                "https://cdn0.wideopenpets.com/wp-content/uploads/2019/03/Untitled-design-2019-03-27T180734.510-770x405.jpg",
                         name:                 "Sokka",
                         approximate_age:      3.0,
                         sex:                  "Male",
                         shelter_id:           @shelter_1.id)
  end

  describe 'On a Pet show page' do
    it "allows a user to see a link to update pet" do
      visit "/pets/#{@pet_3.id}"

      expect(page).to have_link('Update Pet')
    end

    it "once a user clicks on update pet link, redirects user to Pet Edit page" do
      visit "/pets/#{@pet_3.id}"

      click_link('Update Pet')

      expect(current_path).to eq("/pets/#{@pet_3.id}/edit")
    end

    describe 'the Pet Edit page' do
      it 'has forms that allow you to update pet information' do
        visit "/pets/#{@pet_3.id}/edit"

        expect(page).to have_field('Image')
        expect(page).to have_field('Name')
        expect(page).to have_field('Description')
        expect(page).to have_field('Approximate age')
        expect(page).to have_field('Sex')
        expect(page).to have_field('Status')
      end

      it 'once a user clicks on the save button, a PATCH request is sent, the pet is updated, and the user is redirected to Pet Show page' do
        visit "/pets/#{@pet_3.id}/edit"

        fill_in 'Image', with: "https://cdn0.wideopenpets.com/wp-content/uploads/2019/03/Untitled-design-2019-03-27T180734.510-770x405.jpg"
        fill_in 'Name', with: "Sokka of the Southern Water Tribe"
        fill_in 'Description', with: "A good boy who cant waterbend"
        fill_in 'approximate_age', with: "3.2"
        fill_in 'Sex', with: 'Male'
        fill_in 'Status', with: "pending adoption"

        click_button 'Save'

        expect(current_path).to eq("/pets/#{@pet_3.id}")
        expect(page).to have_content("Sokka of the Southern Water Tribe")
        expect(page).to have_content("Status: pending adoption")
        expect(page).to have_content("Approximate Age: 3.2")
        expect(page).to have_content("Sex: Male")
        expect(page).to have_content("Description: A good boy who cant waterbend")
        expect(page).to have_css("img[src*='https://cdn0.wideopenpets.com/wp-content/uploads/2019/03/Untitled-design-2019-03-27T180734.510-770x405.jpg']")
      end
    end
  end
end

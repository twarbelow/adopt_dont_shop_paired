require 'rails_helper'

RSpec.describe "Pet show page", type: :feature do
  before(:each) do

    @shelter_1 = Shelter.create!(name:        "Good Boys Are Us",
                                 address:     "1234 ABC Street",
                                 city:        "Denver",
                                 state:       "Colorado",
                                 zip:         80202)


    @shelter_2 = Shelter.create!(name:        "I Don't Bite Hard",
                                 address:     "4321 CBA Street",
                                 city:        "Revned",
                                 state:       "Colorado",
                                 zip:         80202)

    @pet_1 = Pet.create!(image:               "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
                         name:                "Samson",
                         approximate_age:     4.5,
                         sex:                 "Male",
                         description:         "The best boy",
                         shelter_id:          @shelter_1.id,
                         status:              "pending adoption")


    @pet_2 = Pet.create!(image:               "https://i.pinimg.com/736x/3f/47/7f/3f477ff92627ba171fcc867f23285cf5.jpg",
                         name:                "Delilah",
                         approximate_age:     4.0,
                         sex:                 "Female",
                         description:         "The best girl",
                         shelter_id:          @shelter_1.id,
                         status:              "adoptable")

    @pet_3 = Pet.create!(image:               "https://cdn0.wideopenpets.com/wp-content/uploads/2019/03/Untitled-design-2019-03-27T180734.510-770x405.jpg",
                         name:                "Sokka",
                         approximate_age:     3.0,
                         sex:                 "Male",
                         description:         "The best boy",
                         shelter_id:          @shelter_2.id,
                         status:              "adoptable")
  end

  describe "When a user clicks on the name of a pet" do
    it "takes user from pets index page and redirects the user to that pets show page" do
      visit '/pets'

      click_link("#{@pet_3.name}")

      expect(current_path).to eq("/pets/#{@pet_3.id}")
    end

    it "takes user from shelter pets index page and redirects the user to that pets show page" do
      visit "/shelters/#{@shelter_2.id}/pets"

      click_link("#{@pet_3.name}")

      expect(current_path).to eq("/pets/#{@pet_3.id}")
    end

    it "can display  pet image" do
      visit "/pets/#{@pet_3.id}"

      expect(page).to have_css("img[src*='#{@pet_3.image}']")
    end

    it "can display pet name" do
      visit "/pets/#{@pet_3.id}"

      expect(page).to have_content(@pet_3.name)
    end

    it "can display pet age" do
      visit "/pets/#{@pet_3.id}"

      expect(page).to have_content("Approximate Age: #{@pet_3.approximate_age}")
    end

    it "can display the sex of the pet" do
      visit "/pets/#{@pet_3.id}"

      expect(page).to have_content("Sex: #{@pet_3.sex}")
    end

    it "can display the name of shelter where pet is located" do
      visit "/pets/#{@pet_3.id}"

      expect(page).to have_content(@pet_3.name)
    end

    it "can display the status of the pet" do
      visit "/pets/#{@pet_3.id}"

      expect(page).to have_content("Status: #{@pet_3.status}")
    end
  end
end

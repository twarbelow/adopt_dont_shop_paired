require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name:        "Good Boys Are Us",
                                 address:     "1234 ABC Street",
                                 city:        "Denver",
                                 state:       "Colorado",
                                 zip:         80202)

    @pet_1 = Pet.create(image:               "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
                         name:                "Samson",
                         approximate_age:     4.5,
                         sex:                 "Male",
                         description:         "The best boy",
                         shelter_id:          @shelter_1.id,
                         status:              "pending")


    @pet_2 = Pet.create(image:               "https://i.pinimg.com/736x/3f/47/7f/3f477ff92627ba171fcc867f23285cf5.jpg",
                         name:                "Delilah",
                         approximate_age:     4.0,
                         sex:                 "Female",
                         description:         "The best girl",
                         shelter_id:          @shelter_1.id,
                         status:              "adoptable")

    @pet_3 = Pet.create(image:               "https://cdn0.wideopenpets.com/wp-content/uploads/2019/03/Untitled-design-2019-03-27T180734.510-770x405.jpg",
                         name:                "Sokka",
                         approximate_age:     3.0,
                         sex:                 "Male",
                         description:         "The best boy",
                         shelter_id:          @shelter_1.id,
                         status:              "adoptable")

    @application = App.create({ name:         "Mr. Guy",
                              address:        "4939 Ithica Dr",
                              city:           "Fairbanks",
                              state:          "Alaska",
                              zip:            "99709",
                              phone_number:   "907-474-4929",
                              description:    "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."
                                      })

    @application.pets << [@pet_1, @pet_2]


  end
  describe "When a user visits an application's show page" do
    it "shows a link to approve the application for that specific pet that the application is for" do
      visit "/applications/#{@application.id}"

      within("#pet-links-#{@pet_1.id}") do
        expect(page).to have_link("Approve application for pet: #{@pet_1.name}")
      end
      within("#pet-links-#{@pet_2.id}") do
        expect(page).to have_link("Approve application for pet: #{@pet_2.name}")
      end
    end

    describe "When a user clicks on a link to approve the application for one particular pet" do
      it "takes user back to that pet's show page where they see the status as 'pending' with applicant's name" do
        visit "/applications/#{@application.id}"

        click_link "Approve application for pet: #{@pet_2.name}"
        expect(current_path).to eq("/pets/#{@pet_2.id}")

        expect(page).to have_content "Status: pending"
        save_and_open_page
        expect(page).to have_content "On hold for: #{@application.name}"
      end
    end
  end
end

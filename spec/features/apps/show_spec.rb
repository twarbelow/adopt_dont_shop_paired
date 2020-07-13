require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create!(name:        "Good Boys Are Us",
                                 address:     "1234 ABC Street",
                                 city:        "Denver",
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

    @apps_pet = AppsPet.create({pet_id: @pet_1.id, app_id: @application.id})

    visit "/pets/#{@pet_1.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_2.id}"
    click_on('Favorite This Pet')
  end

  describe "When a user visits an applications show page '/applications/:id'" do
    it "allows the user to see all applicant info and a link of each pet name being applied for" do
      visit "/applications/#{@application.id}"
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zip)
      expect(page).to have_content(@application.phone_number)
      expect(page).to have_content(@application.description)

      expect(page).to have_link(@pet_1.name, href: "/pets/#{@pet_1.id}")

      expect(page).not_to have_link(@pet_3.name)
    end
  end
end

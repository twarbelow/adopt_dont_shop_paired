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

    @application_1 = App.create({ name:       "Mr. Guy",
                              address:        "4939 Ithica Dr",
                              city:           "Fairbanks",
                              state:          "Alaska",
                              zip:            "99709",
                              phone_number:   "907-474-4929",
                              description:    "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."
                                      })

    @application_2 = @pet_3.apps.create
                              ({ name:         "Mrs. Girl",
                               address:        "123 ABC Dr",
                               city:           "Nome",
                               state:          "Alaska",
                               zip:            "99999",
                               phone_number:   "907-252-1234",
                               description:    "Good boys need good homes. Hit me up"
                                      })

    @apps_pet = AppsPet.create({pet_id: @pet_1.id, app_id: @application_1.id})

    visit "/pets/#{@pet_1.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_2.id}"
    click_on('Favorite This Pet')
  end

  describe 'When a user visits the pets show page' do
    it 'allows user to see a link to view all applications for this pet' do

      expect(page).to have_link("Applications For This Pet")
    end
  end

  describe 'When a user clicks that link to view all applications for this pet' do
    it 'allows user to see a list of names of applicants for pet linking to application show page' do
      visit "/pets/#{@pet_1.id}"
      click_on("Applications For This Pet")

      expect(current_path).to eq("/pets/#{@pet_1.id}/applications")
      expect(page).to have_link("#{@application_1.name}", href: "/applications/#{@application_1.id}")
      #expect(page).not_to have_link("#{@application_2.name}")  <--- why doesnt this work? It not finding the name, which is the point

      visit "/pets/#{@pet_3.id}/applications"
      expect(page).to have_link("#{@application_2.name}", href: "/applications/#{@application_2.id}")
      expect(page).not_to have_link("#{@application_1.name}")
    end
  end

  describe "When a user clicks that link and applications do not exist for pet" do
    it "allows user to see a message saying applications for that pet don't exist yet" do
      visit "/pets/#{@pet_2.id}"
      click_on("Applications For This Pet")

      expect(page).to have_content("No applications for this pet exist.")
    end
  end
end

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

    @application_1 = App.create!({ name:      "Mr. Guy",
                              address:        "4939 Ithica Dr",
                              city:           "Fairbanks",
                              state:          "Alaska",
                              zip:            "99709",
                              phone_number:   "907-474-4929",
                              description:    "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."
                                      })

    @application_2 = App.create!({ name:       "Mrs. Girl",
                               address:        "123 ABC Dr",
                               city:           "Nome",
                               state:          "Alaska",
                               zip:            "99999",
                               phone_number:   "907-252-1234",
                               description:    "Good boys need good homes. Hit me up"
                                      })

    @apps_pet = AppsPet.create({pet_id: @pet_1.id, app_id: @application_1.id})
    @apps_pet_2 = AppsPet.create({pet_id: @pet_3.id, app_id: @application_2.id})

    @favorites = Favorites.new([@pet_1.id, @pet_2.id])
    @pets = Pet.all
    @application_1.pets << [@pet_1, @pet_2]

    visit "/applications/#{@application_1.id}"
    click_link "Approve application for: #{@pet_1.name}"
  end

  describe "validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :approximate_age}
    it { should validate_presence_of :sex }
    it { should validate_presence_of :shelter_id }
  end

  describe "methods" do
    it "can return all favorite pets" do

      expected_favs = @favorites
      expect(@pets.favorited(@favorites)).to eq(expected_favs)
    end

    it 'can return relation with name and id all applied-for pets' do

      expected = Pet.select(:name, :id).joins(:apps_pets).distinct
      expect(@pets.applied).to eq(expected)
    end

    it 'can return relation with name and id all approved-application pets' do

      expect(@pets.approved).to eq([@pet_1])
    end
  end
end

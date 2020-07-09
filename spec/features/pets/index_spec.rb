require 'rails_helper'

RSpec.describe "Pet index page", type: :feature do
  before(:each) do

    @shelter_1 = Shelter.create!(name:         "Good Boys Are Us",
                                 address:      "1234 ABC Street",
                                 city:         "Denver",
                                 state:        "Colorado",
                                 zip:          80202)


    @shelter_2 = Shelter.create!(name:         "I Don't Bite Hard",
                                 address:      "4321 CBA Street",
                                 city:         "Revned",
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

    visit '/pets'
  end

  it "can display all pet images" do
    expect(page).to have_css("img[src*='#{@pet_1.image}']")
    expect(page).to have_css("img[src*='#{@pet_2.image}']")
  end

  it "can display all pet names" do
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end

  it "can display all pet ages" do
    expect(page).to have_content("Approximate Age: #{@pet_1.approximate_age}")
    expect(page).to have_content("Approximate Age: #{@pet_2.approximate_age}")
  end

  it "can display the sex of all pets" do
    expect(page).to have_content("Sex: #{@pet_1.sex}")
    expect(page).to have_content("Sex: #{@pet_2.sex}")
  end

  it "can display the name of shelter where pet is located" do
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end
end

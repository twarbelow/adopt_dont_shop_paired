require 'rails_helper'

RSpec.describe 'pet application' do
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

     @pet_3 = Pet.create!(name:                 "Schnooper",
                          approximate_age:      13.0,
                          sex:                  "Male",
                          shelter_id:           @shelter_2.id)

    visit '/favorites'
    expect(page).to have_button("Apply to Adopt")
    click_on("Apply to Adopt")
    expect(current_path).to eq '/favorites/application'
    # is there a better way to expect page to have names of favorited pets (something that validates options to check next to them)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_3.name)
    # is there a better expectation for form with: name, address, city, state, zipcode, phone#, description box
    expect(page).to have_field("Name")
    expect(page).to have_field("Address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zipcode")
    expect(page).to have_field("Phone Number")
    expect(page).to have_field("Description")
    expect(page).to have_button("Submit Application")
  end

  it 'allows a user to apply to adopt many pets' do
    # select @pet_1 @pet_3
    fill_in :address, with: "4939 Ithica Dr"
    fill_in :city, with: "Fairbanks"
    fill_in :state, with: "Alaska"
    fill_in :zipcode, with: "99709"
    fill_in :phone_number, with: "907-474-4929"
    fill_in :description, with: "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."

    click_on("Submit Application")
    expect(current_path).to eq '/favorites'
    expect(page)to_not have_content(@pet_1)
    expect(page)to_not have_content(@pet_3)
    expect(page)to have_content(@pet_2)
  end

  it 'does not allow a user to apply if the form is not complete' do
  end
end

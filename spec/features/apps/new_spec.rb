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
    # expect link "Apply to adopt"
    # click link
    # expect path '/favorites/application'
    # expect page to have names of favorited pets with options to check next to them
    # form with: name, address, city, state, zipcode, phone#, description box
    # expect page to have "Submit Application" button


  end

  it 'allows a user to apply to adopt many pets' do
    # select @pet_1 @pet_3
    # fill in name
    # fill in address
    # fill in city
    # fill in state
    # fill in zipcode
    # fill in phone#
    # fill in description box

    # click 'Submit Application'
    # expect path '/favorites'
    # expect(page)to_not have_content(@pet_1)
    # expect(page)to_not have_content(@pet_3)
    # expect(page)to have_content(@pet_2)
  end

  it 'does not allow a user to apply if the form is not complete' do
  end
end

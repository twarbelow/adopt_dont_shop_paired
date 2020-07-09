require 'rails_helper'

# As a visitor
# When I visit '/shelters'
# Then I see the name of each shelter in the system


RSpec.describe "Shelters index page", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name:        "Good Boys Are Us",
                                address:     "1234 ABC Street",
                                city:        "Denver",
                                state:       "Colorado",
                                zip:         80202)


    @shelter_2 = Shelter.create(name:        "I Don't Bite Hard",
                                address:     "4321 CBA Street",
                                city:        "Revned",
                                state:       "Colorado",
                                zip:         80202)

  end
    it "can see the name of each shelter in the system" do
    visit '/shelters'
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end
end

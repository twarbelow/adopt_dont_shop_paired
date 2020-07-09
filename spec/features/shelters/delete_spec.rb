require 'rails_helper'

RSpec.describe 'Shelter deletion process' do
  before(:each) do
    @shelter_1 = Shelter.create(name:        "Good Boys Are Us",
                                address:     "1234 ABC Street",
                                city:        "Denver",
                                state:       "Colorado",
                                zip:         80202)
  end

  it "allows a user to see a link to delete shelter" do
    visit "/shelters"

    expect(page).to have_button('Delete')
  end

  it 'once a user clicks on the delete button, the shelter is deleted and the postings of pets destroyed' do
    visit "/shelters"

    click_on "Delete"
    expect(current_path).to eq('/shelters')
    expect(page).to_not have_content(@shelter_1.name)
  end
end

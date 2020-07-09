require 'rails_helper'

RSpec.describe "shelter update page", type: :feature do
  before(:each) do

    @shelter_1 = Shelter.create(name:        "Good Boys Are Us",
                                address:     "1234 ABC Street",
                                city:        "Denver",
                                state:       "Colorado",
                                zip:         80202)
  end

  it "allows user to see a link to edit shelter" do
    visit '/shelters'

    expect(page).to have_link("Edit #{@shelter_1.name}")
  end

  it "once a user clicks on edit link, redirects user to shelter edit page" do
    visit '/shelters/'

    click_on "Edit #{@shelter_1.name}"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  it "has forms that allow you to update shelter information" do
    visit "/shelters/#{@shelter_1.id}/edit"

    expect(page).to have_field('Name')
    expect(page).to have_field('Address')
    expect(page).to have_field('City')
    expect(page).to have_field('State')
    expect(page).to have_field('Zip')
  end

  it "once a user clicks on the save button, a PATCH request is sent, the pet is updated, and the user is redirected to Shelter index page" do
    visit "/shelters/#{@shelter_1.id}/edit"

    fill_in 'Name', with: "Nice Dogs Finish Last"
    click_button 'Save'

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("#{@shelter_1.name}")
  end
end

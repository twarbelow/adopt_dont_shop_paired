require 'rails_helper'

RSpec.describe "Shelter Pet creation process", type: :feature do
  before(:each) do

    @shelter_1 = Shelter.create!(name:       "Good Boys Are Us",
                                address:     "1234 ABC Street",
                                city:        "Denver",
                                state:       "Colorado",
                                zip:         80202)


  end

  it "allows user to see a link to add an adoptable pet" do
    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_link('Add Pet')
  end

  it "once a user clicks on the add pet link, user is redirected to pet creation form" do
    visit "/shelters/#{@shelter_1.id}/pets"

    click_on 'Add Pet'
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
  end

  it "once a user fills in the form and clicks on the save pet link, user is redirected to shelter pet index" do
    visit "/shelters/#{@shelter_1.id}/pets/new"

    fill_in :image, with: "https://www.petlandlancaster.com/wp-content/uploads/2019/11/1504500_800.jpg"
    fill_in :name, with: "Haley"
    fill_in :description, with: "The best girl"
    fill_in :approximate_age, with: "0.4"
    fill_in :sex, with: "Female"

    click_on 'Save Pet'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    expect(page).to have_css("img[src*='https://www.petlandlancaster.com/wp-content/uploads/2019/11/1504500_800.jpg']")
    expect(page).to have_content("Haley")
    expect(page).to have_content("Approximate Age: 0.4")
    expect(page).to have_content("Sex: Female")
  end
end

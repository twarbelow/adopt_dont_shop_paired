require 'rails_helper'

RSpec.describe "shelter show page", type: :feature do
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
  it "can shows given shelter's name" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.name)

    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_content(@shelter_2.name)
  end

    it "can shows given shelter's address" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.address)

    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_content(@shelter_2.address)
  end

    it "can shows given shelter's name" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.city)

    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_content(@shelter_2.city)
  end


  it "can shows given shelter's name" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.state)

    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_content(@shelter_2.state)
  end


    it "can shows given shelter's name" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.zip)

    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_content(@shelter_2.zip)
  end
end

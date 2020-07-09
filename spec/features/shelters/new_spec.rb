require 'rails_helper'

RSpec.describe "Shelter creation process", type: :feature do
  it "takes you to a form to create a new shelter" do

    visit '/shelters'

    click_on 'New Shelter'

    expect(current_path).to eq('/shelters/new')

    fill_in :name, with: "Good Boys Are Us"
    fill_in :address, with: "1234 ABC Street"
    fill_in :city, with: "Denver"
    fill_in :state, with: "Colorado"
    fill_in :zip, with: 80202

    click_on 'Create Shelter'
    expect(current_path).to eq("/shelters")
    page.has_content?('Good Boys Are Us')
  end
end

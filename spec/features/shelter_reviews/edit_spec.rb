require 'rails_helper'

RSpec.describe "edit shelter review", type: :feature do
  it "allows you to update shelter review information" do

    shelter_1 = Shelter.create(name:       "Good Boys Are Us",
                               address:     "1234 ABC Street",
                               city:        "Denver",
                               state:       "Colorado",
                               zip:         80202)

    visit "shelters/#{shelter_1.id}"

    click_on "Edit Review for #{shelter_1.name}"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit_review") # <----- path may need changed?

    fill_in :title, with: "It was a cute little place..."
    fill_in :rating, with: 3 # <------ Dependant on db, integer or string
    fill_in :content, with: "Place sucks. Also Brad sucks."
    fill_in :optional_image:, with: "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/thumbs-down.png"

    click_on "Submit Review"

    expect(current_path).to eq("shelters/#{shelter_1.id}")
  end
end

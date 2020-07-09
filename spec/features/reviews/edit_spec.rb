require 'rails_helper'

RSpec.describe "edit shelter review", type: :feature do
  it "allows you to update shelter review information" do

    shelter_1 = Shelter.create(name:        "Good Boys Are Us",
                               address:     "1234 ABC Street",
                               city:        "Denver",
                               state:       "Colorado",
                               zip:         80202)

    review_1 = Review.create(title:         "Best Review",
                             rating:        5,
                             content:       "Such good pets, all the best.",
                             image_path:    "https://www.northeastanimalshelter.org/wp-content/uploads/2013/10/1-IMG_8364-0011.jpg",
                             shelter_id:    shelter_1.id)

    visit "shelters/#{shelter_1.id}"

    expect(page).to have_link("Edit This Review")

    click_on "Edit This Review"

    expect(current_path).to eq("/reviews/#{review_1.id}/edit")

    fill_in :title,           with: "It was a cute little place..."
    fill_in :rating,          with: 3 # <------ Dependant on db, integer or string
    fill_in :content,         with: "Place sucks. Also Brad sucks."
    fill_in :image_path,      with: "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/thumbs-down.png"

    click_on "Submit Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
  end
end

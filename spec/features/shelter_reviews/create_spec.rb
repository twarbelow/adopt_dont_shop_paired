require 'rails_helper'

RSpec.describe "shelter review create page" do
  it "allows user to create a review for this shelter" do
    shelter_1 = Shelter.create(name:       "Good Boys Are Us",
                               address:     "1234 ABC Street",
                               city:        "Denver",
                               state:       "Colorado",
                               zip:         80202)

    visit "shelters/#{shelter_1.id}"

    click_on 'Add Review'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/new_review") # <----- path may need changed?

    fill_in :title, with: "Cute little place!"
    fill_in :rating, with: 4 # <------ Dependant on db, integer or string
    fill_in :content, with: "Omg love this place I go here all the time"
    fill_in :optional_image:, with: "https://i.redd.it/jab5c3kfm8s21.jpg"

    click_on "Submit Review"

    expect(current_path).to eq("shelters/#{shelter_1.id}")
  end
end

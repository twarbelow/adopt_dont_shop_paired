require 'rails_helper'

RSpec.describe 'As a Visitor' do
  it 'allows user to delete a shelter review' do
    shelter_1 = Shelter.create(name:       "Good Boys Are Us",
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

    expect(page).to have_link("Delete This Review")

    click_button 'Delete This Review'

    expect(current_path).to eq("shelters/#{shelter_1.id}")

    expect(page).to_not have_content(review_1.title)
    expect(page).to_not have_content(review_1.content)
    expect(page).to_not have_content(review_1.rating)
  end
end

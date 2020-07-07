require 'rails_helper'

RSpec.describe "shelter reviews index" do
  it "shows user list of reviews for specific shelter on shelter show page" do

    shelter_1 = Shelter.create(name:        "Good Boys Are Us",
                               address:     "1234 ABC Street",
                               city:        "Denver",
                               state:       "Colorado",
                               zip:         80202)


    # If we have a method in shelter that is review, can we call shelter.reviews.create?
    review_1 = Review.create(title:         "Best Review",
                             rating:        5,
                             content:       "Such good pets, all the best.",
                             image_path:    "https://www.northeastanimalshelter.org/wp-content/uploads/2013/10/1-IMG_8364-0011.jpg",
                             shelter_id:    shelter_1.id)

    visit "shelters/#{shelter_1.id}"

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_content(review_1.image_path)
  end
end

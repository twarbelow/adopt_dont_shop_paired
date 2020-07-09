require 'rails_helper'

RSpec.describe "Shelter reviews index" do
  before(:each) do

    @shelter_1 = Shelter.create!(name:        "Good Boys Are Us",
                                 address:     "1234 ABC Street",
                                 city:        "Denver",
                                 state:       "Colorado",
                                 zip:         80202)

    @review_1 = Review.create!(title:         "Best Review",
                               rating:        5,
                               content:       "Such good pets, all the best.",
                               image_path:    "https://www.northeastanimalshelter.org/wp-content/uploads/2013/10/1-IMG_8364-0011.jpg",
                               shelter_id:    @shelter_1.id)

    visit "shelters/#{@shelter_1.id}"
  end

  it "can display review title" do
    expect(page).to have_content(@review_1.title)
  end

  it "can display review rating" do
    expect(page).to have_content(@review_1.rating)
  end

  it "can display review content" do
    expect(page).to have_content(@review_1.content)
  end

  it "can display review image" do
    expect(page).to have_css("img[src*='https://www.northeastanimalshelter.org/wp-content/uploads/2013/10/1-IMG_8364-0011.jpg']")
  end
end

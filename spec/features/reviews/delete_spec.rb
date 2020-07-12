require 'rails_helper'

RSpec.describe 'Review deletion process' do
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

    @review_2 = Review.create!(title:         "Lame Place",
                               rating:        2,
                               content:       "Doggo did me a bite.",
                               image_path:    "https://www.dictionary.com/e/wp-content/uploads/2018/05/doggo-300x300.jpg",
                               shelter_id:    @shelter_1.id)
  end

  it 'allows user to see a link to delete a shelter review' do
    visit "shelters/#{@shelter_1.id}"

    within "#review-#{@review_1.id}" do
      expect(page).to have_link('Delete This Review')
    end

    within "#review-#{@review_2.id}" do
       expect(page).to have_link('Delete This Review')
    end
  end

  it 'once a user clicks on the delete link, the review is deleted and user is redirected to the shelter show page' do
    visit "shelters/#{@shelter_1.id}"

    within "#review-#{@review_2.id}" do
        click_link 'Delete This Review'
    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to have_css("#review-#{@review_1.id}")
    expect(page).not_to have_css("#review-#{@review_2.id}")
  end
end

require 'rails_helper'

RSpec.describe "new shelter review" do
  describe 'As a visitor'
    before(:each) do
      @shelter_1 = Shelter.create(name:        "Good Boys Are Us",
                                 address:     "1234 ABC Street",
                                 city:        "Denver",
                                 state:       "Colorado",
                                 zip:         80202)
      visit "shelters/#{@shelter_1.id}"
      click_on "Add Review"
    end

    it "I can create a review for this shelter" do
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in :title,           with: "Cute little place!"
      select('4', from: :rating)
      fill_in :content,         with: "Omg love this place I go here all the time"
      fill_in :image_path,      with: "https://i.redd.it/jab5c3kfm8s21.jpg"

      click_on "Submit Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      review = Review.last
      expect(page).to have_content(review.title)
      expect(page).to have_content(review.rating)
      expect(page).to have_content(review.content)
    end

    it 'I cannot create a review for this shelter without a title, rating, and content' do
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in :title,           with: "Cute little place!"
      fill_in :content,         with: "Omg love this place I go here all the time"
      fill_in :image_path,      with: "https://i.redd.it/jab5c3kfm8s21.jpg"

      click_on "Submit Review"
      save_and_open_page

      expect(page).to have_content("Review not submitted: Required information missing.")
    end
end

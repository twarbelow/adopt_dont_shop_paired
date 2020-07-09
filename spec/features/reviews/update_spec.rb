require 'rails_helper'

RSpec.describe "Update shelter review process", type: :feature do
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

  describe "When I visit a shelter's show page" do
    it "allows a user to see a link to update review" do
      visit "shelters/#{@shelter_1.id}"

      within "#review-#{@review_1.id}" do
        expect(page).to have_link("Edit This Review")
      end

      within "#review-#{@review_2.id}" do
        expect(page).to have_link("Edit This Review")
      end
    end

    it "once a user clicks on update pet link, redirects user to shelter review edit page" do
      visit "shelters/#{@shelter_1.id}"

      within "#review-#{@review_1.id}" do
        click_link("Edit This Review")
      end
      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
    end
  end

  describe "Inside of then edit shelter review page" do
    it "has forms that allow you to update review information" do
      visit("/reviews/#{@review_1.id}/edit")

      expect(find_field('Title').value).to eq(@review_1.title)
      expect(find_field('Rating').value).to eq(@review_1.rating.to_s)
      expect(find_field('Content').value).to eq(@review_1.content)
      expect(find_field('Image path').value).to eq(@review_1.image_path)
    end

    it 'once a user clicks on the submit review button, a PATCH request is sent, the recview is updated, and the user is redirected to shelter show page' do
      visit("/reviews/#{@review_1.id}/edit")

      fill_in :title,           with: "It was a cute little place..."
      fill_in :rating,          with: 3
      fill_in :content,         with: "Place sucks. Also Brad sucks."
      fill_in :image_path,      with: "https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/thumbs-down.png"

      click_on "Submit Review"

      expect(current_path).to eq("/shelters/#{@review_1.shelter.id}")
      expect(page).to have_content("It was a cute little place...")
      expect(page).to have_content("Rating: 3")
      expect(page).to have_content("Place sucks. Also Brad sucks.")
      expect(page).to have_css("img[src*='https://s3.amazonaws.com/pix.iemoji.com/images/emoji/apple/ios-12/256/thumbs-down.png']")
    end
  end
end

require 'rails_helper'

RSpec.describe Favorites, type: :model do
  before(:each) do
    @favorites = Favorites.new(@favorite_pets)
    @favorite_pets = favorite_pets ||= Array.new

    @shelter_1 = Shelter.create!(name:         "Good Boys Are Us",
                                 address:      "1234 ABC Street",
                                 city:         "Denver",
                                 state:        "Colorado",
                                 zip:          80202)

    @pet_1 = Pet.create!(image:                "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
                         name:                 "Samson",
                         approximate_age:      4.5,
                         sex:                  "Male",
                         shelter_id:           @shelter_1.id)


    @pet_2 = Pet.create!(image:                "https://i.pinimg.com/736x/3f/47/7f/3f477ff92627ba171fcc867f23285cf5.jpg",
                         name:                 "Delilah",
                         approximate_age:      4.0,
                         sex:                  "Female",
                         shelter_id:           @shelter_1.id)
  end

  describe "methods" do
    it "can initialize with array of pet ids" do
      @favorites.add(@pet_1.id)
      @favorites.add(@pet_2.id)
      expect(@favorites.favorite_pets).to eq([@pet_1.id, @pet_2.id])
    end

    it "can initialize with an empty array" do
      expect(@favorites.favorite_pets).to eq([])
    end

    it "can add pets to favorites" do
      expect(@favorites.favorite_pets).to eq([])
      @favorites.add(@pet_1.id)
      expect(@favorites.favorite_pets).to eq([@pet_1.id])
    end

    it "can count the amount of pets a user has favorited" do
      @favorites.add(@pet_1.id)
      @favorites.sum_favorites
      expect(@favorites.sum_favorites).to eq(1)
    end

    it "can see if a pet is already favorited" do

      expect(@favorites.is_already_favorited?("#{@pet_1.id}")).to eq(false)
    end

    it "can delete pet ids from array" do
      @favorites.add(@pet_1.id)

      expect(@favorites.sum_favorites).to eq(1)

      @favorites.delete(@pet_1.id)

      expect(@favorites.sum_favorites).to eq(0)
    end

    it "can delete all pet ids from array" do
      @favorites.add(@pet_1.id)
      @favorites.add(@pet_2.id)

      expect(@favorites.sum_favorites).to eq(2)

      @favorites.delete_all

      expect(@favorites.sum_favorites).to eq(0)
    end
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shelter.destroy_all
Review.destroy_all
Pet.destroy_all

shelter_1 = Shelter.create!(name:       "Good Boys Are Us",
                           address:     "1234 ABC Street",
                           city:        "Denver",
                           state:       "Colorado",
                           zip:         80202)


shelter_2 = Shelter.create!(name:       "I Don't Bite Hard",
                           address:     "4321 CBA Street",
                           city:        "Revned",
                           state:       "Colorado",
                           zip:         80202)

pet_1 = Pet.create!(image:              "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
                   name:                "Samson",
                   approximate_age:     4.5,
                   sex:                 "Male",
                   description:         "The best boy",
                   shelter_id:          shelter_1.id,
                   status:              "pending adoption")


pet_2 = Pet.create!(image:              "https://i.pinimg.com/736x/3f/47/7f/3f477ff92627ba171fcc867f23285cf5.jpg",
                   name:                "Delilah",
                   approximate_age:     4.0,
                   sex:                 "Female",
                   description:         "The best girl",
                   shelter_id:          shelter_1.id,
                   status:              "adoptable")

pet_3 = Pet.create!(image:               "https://cdn0.wideopenpets.com/wp-content/uploads/2019/03/Untitled-design-2019-03-27T180734.510-770x405.jpg",
                    name:                "Sokka",
                    approximate_age:     3.0,
                    sex:                 "Male",
                    description:         "The best boy",
                    shelter_id:          shelter_2.id,
                    status:              "adoptable")

review_1 = Review.create(title:         "Best Review",
                         rating:        5,
                         content:       "Such good pets, all the best.",
                         image_path:    "https://www.northeastanimalshelter.org/wp-content/uploads/2013/10/1-IMG_8364-0011.jpg",
                         shelter_id:    shelter_1.id)

review_2 = Review.create!(title:         "Lame Place",
                          rating:        2,
                          content:       "Doggo did me a bite.",
                          image_path:    "https://www.dictionary.com/e/wp-content/uploads/2018/05/doggo-300x300.jpg",
                          shelter_id:    shelter_1.id)

class App < ApplicationRecord
  has_many :apps_pets
  has_many :pets, through: :apps_pets
end

class App < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :phone_number
  validates_presence_of :description

  has_many :apps_pets
  has_many :pets, through: :apps_pets
end

class Pet < ApplicationRecord
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
  validates_presence_of :shelter_id
  belongs_to :shelter
  has_many :apps_pets
  has_many :apps, through: :apps_pets

  def self.favorited(favorites)
    favorites
  end

  def self.applied
    select(:name, :id).joins(:apps_pets).distinct
  end
end

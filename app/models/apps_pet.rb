class AppsPet < ApplicationRecord
  validates_presence_of :app_id, :pet_id
  belongs_to :app
  belongs_to :pet
end

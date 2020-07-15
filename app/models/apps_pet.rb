class AppsPet < ApplicationRecord
  validates_presence_of :app_id, :pet_id
  belongs_to :app
  belongs_to :pet
  # self.bool_field = false if self.bool_field.nil?
  attribute :approved, default: false
end

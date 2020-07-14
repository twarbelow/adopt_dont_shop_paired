require 'rails_helper'

RSpec.describe App, type: :model do
  it "can create app" do
    @application_1 = App.create!({ name:       "Mr. Guy",
                               address:        "4939 Ithica Dr",
                               city:           "Fairbanks",
                               state:          "Alaska",
                               zip:            "99709",
                               phone_number:   "907-474-4929",
                               description:    "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."
                                      })

  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :description}
  end
end

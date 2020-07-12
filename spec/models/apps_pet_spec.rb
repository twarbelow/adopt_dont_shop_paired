require 'rails_helper'

RSpec.describe AppsPet do
  describe 'validations' do
    it { should validate_presence_of :app_id }
    it { should validate_presence_of :pet_id }
  end
  describe 'relationships' do
    it { should belong_to :app}
    it { should belong_to :pet }
  end
end

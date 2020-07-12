require 'rails_helper'

RSpec.describe 'it shows a favorites index page' do
  it ' when the favorites indicator is clicked' do
    visit '/shelters'

    find('.fav-pets').click
    expect(current_path).to eq '/favorites'
  end
end

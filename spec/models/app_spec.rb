require 'rails_helper'

RSpec.describe App, type: :model do
  it "can create app" do
    App.create!
  end
end

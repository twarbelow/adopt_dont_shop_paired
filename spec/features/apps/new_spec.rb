require 'rails_helper'

RSpec.describe 'pet application' do
  before(:each) do
    @shelter_1 = Shelter.create!(name:         "Good Boys Are Us",
                                 address:      "1234 ABC Street",
                                 city:         "Denver",
                                 state:        "Colorado",
                                 zip:          80202)

    @pet_1 = Pet.create!(image:                "https://www.vieravet.com/sites/default/files/styles/large/adaptive-image/public/golden-retriever-dog-breed-info.jpg?itok=LCRMRkum",
                         name:                 "Samson",
                         approximate_age:      4.5,
                         sex:                  "Male",
                         shelter_id:           @shelter_1.id)

    @pet_2 = Pet.create!(image:                "https://i.pinimg.com/736x/3f/47/7f/3f477ff92627ba171fcc867f23285cf5.jpg",
                         name:                 "Delilah",
                         approximate_age:      4.0,
                         sex:                  "Female",
                         shelter_id:           @shelter_1.id)

     @pet_3 = Pet.create!(image:                "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.amazon.com%2FDahey-Hedgehog-Plastic-Decoration-Hamster%2Fdp%2FB06XK495CL&psig=AOvVaw3V-7f11Pm7eVMSar5TYz_p&ust=1594750899460000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICq95nsyuoCFQAAAAAdAAAAABAD",
                          name:                 "Schnooper",
                          approximate_age:      13.0,
                          sex:                  "Male",
                          shelter_id:           @shelter_1.id)
  end

  def prepare_favorites
    visit "/pets/#{@pet_1.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_2.id}"
    click_on('Favorite This Pet')
    visit "/pets/#{@pet_3.id}"
    click_on('Favorite This Pet')

    visit '/favorites'
    click_on("Apply to Adopt")
  end

  it 'allows a user to apply to adopt many pets' do
    prepare_favorites

    # page.check("#{@pet_1.name}[]")
    find(:css, "#pet_ids_[value='#{@pet_1.id}']").set(true)
    # page.check("#{@pet_3.name}[]")
    find(:css, "#pet_ids_[value='#{@pet_3.id}']").set(true)

    fill_in :name, with: "CatLady"
    fill_in :address, with: "4939 Ithaca Dr"
    fill_in :city, with: "Fairbanks"
    fill_in :state, with: "Alaska"
    fill_in :zip, with: "99709"
    fill_in :phone_number, with: "907-474-4929"
    fill_in :description, with: "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."

    find('input[name="commit"]').click

    expect(current_path).to eq '/favorites'
    expect(page).to_not have_content(@pet_1.name)
    expect(page).to_not have_content(@pet_3.name)
    expect(page).to have_content(@pet_2.name)
  end

  it 'does not allow a user to apply if the form is not complete' do
    prepare_favorites

    # page.check("#{@pet_1.name}[]")
    find(:css, "#pet_ids_[value='#{@pet_1.id}']").set(true)
    # page.check("#{@pet_3.name}[]")
    find(:css, "#pet_ids_[value='#{@pet_3.id}']").set(true)

    fill_in :address, with: "4939 Ithaca Dr"
    fill_in :city, with: "Fairbanks"
    fill_in :state, with: "Alaska"
    fill_in :zip, with: "99709"
    fill_in :description, with: "Endless love to give all the animals. Wet food for every cat, tennis balls for ever dog."

    find('input[name="commit"]').click

    expect(current_path).to eq '/applications'
    expect(page).to have_content("Application not submitted: Required information missing.")


  end
end

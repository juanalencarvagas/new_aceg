require 'rails_helper'

feature 'User visits pet with ong info' do
  scenario 'successfuly' do
    user = create(:user)
    ong = create(:ong, user: user)
    pet = create(:pet, ong: ong)

    visit root_path

    click_on pet.name

    expect(page).to have_content pet.name
    expect(page).to have_content pet.age
    expect(page).to have_content pet.size
    expect(page).to have_content pet.pet_type
    expect(page).to have_content pet.breed
    expect(page).to have_content pet.gender
    page.has_css?('i glyphicon glyphicon-remove')
    expect(page).to have_content pet.deficiency
    expect(page).to have_content pet.description
    expect(page).to have_xpath('//img')
    expect(page).to have_content ong.name
    expect(page).to have_content ong.email
    expect(page).to have_content ong.phone
    expect(page).to have_content ong.contact
    expect(page).to have_content ong.city
    expect(page).to have_content ong.state
    expect(page).to have_content ong.street
  end
end

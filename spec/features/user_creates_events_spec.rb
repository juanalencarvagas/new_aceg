require 'rails_helper'

feature 'user creates events to ong' do
  scenario 'successfully' do
    ong = create(:ong)
    visit ong_path ong

    click_on 'Criar Evento'

    event = build(:event)
    fill_in 'Nome', with: event.name
    fill_in 'Endereço', with: event.address
    select '2016', from: 'event[datetime(1i)]'
    select 'Outubro', from: 'event[datetime(2i)]'
    select '10', from: 'event[datetime(3i)]'
    select '22', from: 'event[datetime(4i)]'
    select '10', from: 'event[datetime(5i)]'

    click_on 'Enviar'

    expect(page).to have_content(event.name)
    expect(page).to have_content(event.address)
    expect(page).to have_content('10/10/2016 22:10')
    expect(page).to have_content(ong.name)
  end

  scenario 'user see event in the home page' do
    ong = create(:ong)
    event = create(:event, ong: ong, datetime: DateTime.new(2016, 10, 4,
                                                            8, 0).in_time_zone)

    visit root_path

    expect(page).to have_content(event.name)
    expect(page).to have_content('04/10/2016 08:00')
  end

  scenario 'user see event in the ong page' do
    ong = create(:ong)
    events = create_list(:event, 5, ong: ong,
                                    datetime: DateTime.new(2016, 10, 4,
                                                           8, 0).in_time_zone)

    visit ong_path ong

    events.each do |event|
      expect(page).to have_content(event.name)
    end
  end

  scenario 'should fail because all fields are mandatory' do
    ong = create(:ong)
    visit ong_path ong

    click_on 'Criar Evento'

    click_on 'Enviar'

    expect(page).to have_content('Todos os campos com (*) são obrigatórios')
  end
end
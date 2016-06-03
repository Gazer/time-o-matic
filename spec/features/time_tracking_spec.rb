require 'spec_helper.rb'

feature "Time tracking", js: true do
  scenario "start a new track" do
    visit '/'
    fill_in "name", with: "nombre de la tarea"
    click_on "Empezar"

    expect(page).to have_content("nombre de la tarea")
  end

  scenario "stop current track" do
    TrackedTime.create name: 'tracking'
    visit '/'
    click_on 'Finalizar'

    expect(page).to_not have_content("nombre de la tarea")
    expect(page).to have_content("Empezar")
  end

  scenario "stop current track" do
    TrackedTime.create name: 'tracking'
    visit '/'
    click_on 'Finalizar'
    click_on 'Borrar'

    expect(page).to_not have_content("nombre de la tarea")
    expect(page).to have_content("Empezar")
    expect(TrackedTime.count).to eq(0)
  end

end

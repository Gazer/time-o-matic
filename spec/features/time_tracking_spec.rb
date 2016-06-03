require 'spec_helper.rb'

feature "Time tracking", js: true do
  scenario "start a new track" do
    visit '/'
    fill_in "name", with: "nombre de la tarea"
    click_on "Empezar"

    expect(page).to have_content("nombre de la tarea")
  end
end

require 'spec_helper.rb'

feature "Time tracking", js: true do
  scenario "start a new track" do
    visit '/'
    fill_in "name", with: "track name"
    click_on "Empezar"

    expect(page).to have_content("track name")
    expect(page).to_not have_content("Empezar")
  end

  scenario "stop current track" do
    visit '/'
    fill_in "name", with: "track name"
    click_on "Empezar"
    click_on 'Finalizar'

    expect(page).to_not have_content("Finalizar")
    expect(page).to have_content("Empezar")
  end

  scenario "stop current track" do
    visit '/'
    fill_in "name", with: "track name"
    click_on "Empezar"
    click_on "Finalizar"
    click_on 'Borrar'

    expect(page).to_not have_content('my tracking')
  end

end

require 'rails_helper'

# [] Visiting the `/restaurants` path should contain a list of restaurants.
# [] Visiting the `/restaurants/10` path should show the restaurant details for a restaurant with the ID of 10.
# [] Visiting the root path should display a list of all restaurants.

feature "visitor sees a list of restaurants" do
  scenario "sees a list of restaurants and link for new restaurant" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '12111')
    rock_bottom = Restaurant.create(name: "Rock Bottom", address: "Beach street", city: "Boston", state: "MA", zip: "12112")

    visit restaurants_path

    expect(page).to have_content "Rock Bottom"
    expect(page).to have_link "Dumpling King"

    click_link "Add New Restaurant"

    expect(page).to have_content "New Restaurant Form"
  end
  scenario "clicks link and is taken to show page for given restaurant" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '12111', description: "Straightforward dumplings for a great price.")

    visit root_path

    click_link "Dumpling King"

    expect(page).to have_content dumpling_king.name
    expect(page).to have_content dumpling_king.address
    expect(page).to have_content dumpling_king.city
    expect(page).to have_content dumpling_king.state
    expect(page).to have_content dumpling_king.zip
    expect(page).to have_content dumpling_king.description
  end
end

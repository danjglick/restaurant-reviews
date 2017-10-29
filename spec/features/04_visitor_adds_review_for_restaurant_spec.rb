require 'rails_helper'

# [] Visiting the `/restaurants/1/reviews/new` should display a form for creating a new review for a restaurant with ID = 1.
# [] A review should validate must contain the following:
#   [] A review body of text
#   [] A review rating of text
#   [] The relationship to a bathroom

feature "visitors can add reviews for restaurants" do
  scenario "adds a review for a restaurant successfully" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '12111', description: "Straightforward dumplings for a great price.")

    visit restaurant_path(dumpling_king)

    click_link "Add a Review"

    expect(page).to have_content "Review Form for Dumpling King"

    fill_in "Rating", with: 5
    fill_in "Review", with: "This is a raving review!"
    click_button "Add Review"

    expect(page).to have_content "Review added successfully"
    expect(page).to have_content dumpling_king.name
    expect(page).to have_content 5
    expect(page).to have_content "This is a raving review!"
  end

  scenario "adds a review for a restaurant unsuccessfully" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '12111', description: "Straightforward dumplings for a great price.")

    visit restaurant_path(dumpling_king)

    click_link "Add a Review"
    expect(page).to have_content "Review Form for Dumpling King"

    click_button "Add Review"

    expect(page).to have_content "Body can't be blank"
    expect(page).to have_content "Rating can't be blank"
  end
end

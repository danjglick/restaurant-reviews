require 'rails_helper'

# [] A restaurant can have many reviews. Each review must contain the following:
#   [] A rating
#   [] A body
#   [] A timestamp for when it was created
# [] Visiting the `/restaurants/1` path should also include all reviews for a restaurant with ID = 1.

feature "visitor sees list of reviews on restaurant page" do
  scenario "sees reviews for specific restaurant" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '12111')
    review_for_dumplings = Review.create(rating: 4, body: "The pork and leek is my favorite as I think it's a bit juicier than the other options", restaurant: dumpling_king)

    visit restaurant_path(dumpling_king)

    expect(page).to have_content dumpling_king.name
    expect(page).to have_content review_for_dumplings.rating
    expect(page).to have_content review_for_dumplings.body
    expect(page).to have_content review_for_dumplings.created_at.strftime("%B %d %Y")
  end

  scenario "does not see other reviews for other restaurants" do
    dumpling_king = Restaurant.create(name: 'Dumpling King', address: '33 Harrison Ave', city: 'Boston', state: 'MA', zip: '12111')
    rock_bottom = Restaurant.create(name: "Rock Bottom", address: "Beach street", city: "Boston", state: "MA", zip: "12112")
    review_for_dumplings = Review.create(rating: 4, body: "The pork and leek is my favorite as I think it's a bit juicier than the other options", restaurant: dumpling_king)
    review_for_rock = Review.create(rating: 5, body: "Get the nachos!", restaurant: rock_bottom)

    visit restaurant_path(rock_bottom)

    expect(page).to have_content rock_bottom.name
    expect(page).to have_content review_for_rock.body

    expect(page).not_to have_content dumpling_king.name
    expect(page).not_to have_content review_for_dumplings.rating
    expect(page).not_to have_content review_for_dumplings.body
  end
end

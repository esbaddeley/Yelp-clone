require 'rails_helper'
require 'web_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    leave_review
  end

  scenario 'only lets users create one review per restaurant' do
    visit '/restaurants'
    user_signup
    leave_review
    leave_review2
    expect(page).not_to have_content 'amazeballs'
  end

  scenario 'users can delete reviews' do
    visit '/restaurants'
    user_signup
    leave_review
    click_link 'Delete review'
    expect(page).to_not have_content 'so so'
    expect(page).to have_content "Restaurant deleted successfully"
  end

  scenario 'users can only delete their own reviews' do
    visit '/restaurants'
    user_signup
    leave_review
    click_link('Sign out')
    user2_signup
    click_link 'Delete review'
    expect(page).to have_content 'so so'
    expect(page).to have_content "Only the owner can delete this review"
  end

  scenario 'displays an everage rating for all reviews' do
    visit '/restaurants'
    user_signup
    leave_review
    click_link('Sign out')
    user2_signup
    leave_review2
    expect(page).to have_content('Average rating: 4')
  end

end

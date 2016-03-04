def user_signup
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def user2_signup
  click_link('Sign up')
  fill_in('Email', with: 'bob@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def create_restaurant
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'pizza express'
  click_button 'Create Restaurant'
end

def leave_review
  click_link 'Review KFC'
  fill_in "Thoughts", with: "so so"
  select '3', from: 'Rating'
  click_button 'Leave Review'
end

def leave_review2
  click_link 'Review KFC'
  fill_in "Thoughts", with: "amazeballs"
  select '5', from: 'Rating'
  click_button 'Leave Review'
end

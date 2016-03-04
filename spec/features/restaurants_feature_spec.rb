require 'rails_helper'
require 'web_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'KFC')
  end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end


  context 'creating restaurants' do

    context 'user is not logged in' do
      it 'does not let a user that is not logged in add a restaurant' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(current_path).to eq '/users/sign_in'
        expect(page).to have_content 'Log in'
      end
    end

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      user_signup
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context ' an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        user_signup
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restaurants' do

    let!(:kfc){Restaurant.create(name: 'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end

  end

  context 'editing restaurant' do

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      user_signup
      create_restaurant
      click_link 'Edit pizza express'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'users can only edit restaurants they have created' do
      visit('/')
      user_signup
      create_restaurant
      click_link('Sign out')
      user2_signup
      click_link('Edit pizza express')
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content('User can only edit his/her own restaurants')
    end

  end

  context 'deleting restaurants' do

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      user_signup
      create_restaurant
      click_link 'Delete pizza express'
      expect(page).not_to have_content 'pizza express'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'users can only delete restaurants they have created' do
      visit('/')
      user_signup
      create_restaurant
      click_link('Sign out')
      user2_signup
      click_link('Delete pizza express')
      expect(page).to have_content('User can only delete his/her own restaurants')
    end
  end


end

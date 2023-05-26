require 'rails_helper'

RSpec.describe 'Inventories', type: :system do
  describe 'GET /index' do
    let(:user) do
      User.create!(
        name: 'Kender Romain',
        email: 'kenderromain@mail.com',
        password: 'K@i14969'
      )
    end
    let(:inventory) do
      Inventory.create!(
        name: 'Inventory 1',
        description: 'This is my inventory',
        user_id: user.id
      )
    end
    before(:each) do
      user.save
      inventory.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it 'Test if inventories is loading correctly the body and have as title Inventories' do
      visit '/inventories'
      expect(page).to have_content('Inventories')
    end

    it 'Test if inventories is loading correctly the body and have the New inventory button' do
      visit '/inventories'
      expect(page).to have_content('New inventory')
    end

    it 'Redirects from inventories index to inventories show Inventory 1' do
      visit '/inventories'
      link = find_link('New inventory').click
      expect(page).to have_current_path("/inventories/new", ignore_query: true)
    end
  end

  describe 'GET /show' do
    let(:user) do
      User.create!(
        name: 'Kender Romain',
        email: 'kenderromain@mail.com',
        password: 'K@i14969'
      )
    end
    let(:inventory) do
      Inventory.create!(
        name: 'Inventory 1',
        description: 'This is my inventory',
        user_id: user.id
      )
    end
    before(:each) do
      user.save
      inventory.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it 'renders the add food to inventory functionality' do
      visit "/inventories/#{inventory.id}"
      expect(page).to have_content('Add food to inventory')
    end

    it 'Test if the displayed inventory is the one that we created' do
      visit "/inventories/#{inventory.id}"
      expect(page).to have_content('Inventory 1')
    end

    it 'Test in the displayed inventory the presence of Add food' do
      visit "/inventories/#{inventory.id}"
      link = find_link('Add food').click
      expect(page).to have_current_path("/foods/new", ignore_query: true)
    end

  end


end

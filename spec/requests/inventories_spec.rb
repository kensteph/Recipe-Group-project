require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
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

    it 'renders index template' do
      get '/inventories'
      expect(response).to render_template(:index)
    end

    it 'renders a successful response' do
      get '/inventories'
      expect(response).to be_successful
    end

    it 'Test if inventories is loading correctly the body and have as title Inventories' do
      get '/inventories'
      expect(response.body).to include('Inventories')
    end

    it 'Test if inventories is loading correctly the body and have the New inventory button' do
      get '/inventories'
      expect(response.body).to include('New inventory')
    end

    it 'Test if inventories is loading correctly the body' do
      get '/inventories'
      expect(response.body).to include('Inventory 1')
    end

    it 'Test if inventory is the one that wecreated' do
      get '/inventories'
      expect(response.body).to include('Inventory 1')
      expect(response.body).to include('This is my inventory')
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

    it 'renders show template' do
      get "/inventories/#{inventory.id}"
      expect(response).to render_template(:show)
    end

    it 'Test if the displayed inventory is the one that we created' do
      get "/inventories/#{inventory.id}"
      expect(response.body).to include('Inventory 1')
    end

    it 'Test in the displayed inventory the presence of Add food' do
      get "/inventories/#{inventory.id}"
      expect(response.body).to include('Add food')
    end
  end
end

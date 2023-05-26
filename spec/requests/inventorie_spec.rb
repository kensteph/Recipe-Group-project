require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
  describe 'GET /index' do
    it 'renders index template' do
      get '/inventories'
      expect(response).to render_template(:index)
    end
    it 'renders a successful response' do
      get '/inventories'
      expect(response).to be_successful
    end

    it 'Test if /users is loading correctly the body' do
      get '/inventories'
      expect(response.body).to include('Inventories')
    end
  end

  describe 'GET /show' do
    it 'renders show template' do
      inventory = Inventory.create(name: 'My Inventory', user_id: 1)
      get "/inventories/#{inventory.id}"
      expect(response).to render_template(:show)
    end

    it 'renders a successful response' do
      inventory = Inventory.create(name: 'My Inventory', user_id: 1)
      get "/inventories/#{inventory.id}"
      expect(response).to be_successful
    end

    it 'Test if /inventories/:id is loading correctly the body' do
      inventory = Inventory.create(name: 'My Inventory', user_id: 1)
      get "/inventories/#{inventory.id}"
      expect(response.body).to include('My Inventory')
    end
  end

end
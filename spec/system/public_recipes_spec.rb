require 'rails_helper'

RSpec.describe 'Public Recipes', type: :request do
  describe 'GET /index' do
    let(:user) do
      User.create!(
        name: 'Tom',
        email: 'test@mail.com',
        password: '123456'
      )
    end
    let(:recipe) do
      Recipe.create!(
        name: 'icecream',
        preparation_time: 3,
        cooking_time: 4,
        description: 'ice cream made easy',
        public: true,
        user: user
      )
    end
    before(:each) do
      get public_recipes_path(user_id: user.id)
      recipe.save
    end

    it 'renders index template' do
      get '/public_recipes'
      expect(response).to render_template(:index)
    end
    it 'renders a successful response' do
      get '/public_recipes'
      expect(response).to be_successful
    end

    it 'Test if /public_recipe is loading correctly the body' do
      get '/public_recipes'
      expect(response.body).to include('Public Recipes')
    end

    it 'Test if /recipes has the right recipe created' do
      get '/public_recipes'
      expect(response.body).to include('Tom')
      expect(response.body).to include('icecream')
    end
  end
end


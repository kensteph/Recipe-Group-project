require 'rails_helper'

RSpec.describe 'Recipe', type: :request do
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
      get recipes_path(user_id: user.id)
      recipe.save
    end

    it 'renders index template' do
      get '/recipes'
      expect(response).to render_template(:index)
    end
    it 'renders a successful response' do
      get '/recipes'
      expect(response).to be_successful
    end

    it 'Test if /recipes is loading correctly the body' do
      get '/recipes'

      expect(response.body).to include('Recipes')
      expect(response.body).to include('New recipe')
      expect(response.body).to include('icecream')
    end

    it 'Test if /recipes has the right recipe created' do
      get '/recipes'
      expect(response.body).to include('ice cream made easy')
      expect(response.body).to include('icecream')
    end
  end
end

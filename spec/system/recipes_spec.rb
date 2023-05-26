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
        user:
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
  describe 'GET /show' do
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
        user:
      )
    end
    let(:food1) do 
      Food.create(name: 'Apple', measurement_unit: 'kg', price: 2.5)
    end
    let(:food2) do 
      Food.create(name: 'Flour', measurement_unit: 'kg', price: 1.2)
    end
    let (:food3) do 
      Food.create(name: 'Egg', measurement_unit: 'units', price: 0.8)
    end
    let(:r_foods1) { RecipeFood.create(quantity: 1, recipe_id: recipe.id, food_id: food1.id) }
    let(:r_foods2) { RecipeFood.create(quantity: 2, recipe_id: recipe.id, food_id: food2.id) }
    let(:r_foods3) { RecipeFood.create(quantity: 3, recipe_id: recipe.id, food_id: food3.id) }
    
    before(:each) do      
      recipe.save
    end

    it "Should display the food's name." do
      visit "recipes/#{recipe.id}"     
      expect(page).to have_content(food1.name)
      expect(page).to have_content(food2.name)
      expect(page).to have_content(food3.name)
    end

    it "Should display the food's price." do
      visit "recipes/#{recipe.id}"     
      expect(page).to have_content(food1.price)
      expect(page).to have_content(food2.price)
      expect(page).to have_content(food3.price)
    end

    it "Should display the food's quantity." do
      visit "recipes/#{recipe.id}"     
      expect(page).to have_content(r_foods1.quantity)
      expect(page).to have_content(r_foods2.quantity)
      expect(page).to have_content(r_foods3.quantity)
    end      
  end
end

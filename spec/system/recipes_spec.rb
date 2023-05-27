require 'rails_helper'
RSpec.describe 'Recipe', type: :system do
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
      recipe.save
      user.save
    end
    it "Should render the recipe's name." do
      visit '/recipes'
      expect(page).to have_content(recipe.name)
    end

    it "Should render the recipe's description." do
      visit '/recipes'
      expect(page).to have_content(recipe.description)
    end

    it 'Should render the new recipe button.' do
      visit '/recipes'
      expect(page).to have_content('New recipe')
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
      Food.create!(name: 'Apple', measurement_unit: 'kg', price: 2.5, user_id: user.id)
    end
    let(:food2) do
      Food.create!(name: 'Flour', measurement_unit: 'kg', price: 1.2, user_id: user.id)
    end
    let(:food3) do
      Food.create!(name: 'Egg', measurement_unit: 'units', price: 0.8, user_id: user.id)
    end
    let(:r_foods1) { RecipeFood.create!(quantity: 1, recipe_id: recipe.id, food_id: food1.id) }
    let(:r_foods2) { RecipeFood.create!(quantity: 2, recipe_id: recipe.id, food_id: food2.id) }
    let(:r_foods3) { RecipeFood.create!(quantity: 3, recipe_id: recipe.id, food_id: food3.id) }
    before(:each) do
      user.save
      recipe.save
      food1.save
      food2.save
      food3.save
      r_foods1.save
      r_foods2.save
      r_foods3.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
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

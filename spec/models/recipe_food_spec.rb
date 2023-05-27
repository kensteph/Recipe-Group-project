require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.new(name: 'roody', email: 'roody@mail.com') }
  let(:recipe) do
    Recipe.create(
      name: 'Brownie Cake',
      preparation_time: 1,
      cooking_time: 2,
      description: 'A sweet cake with chocolate',
      public: true,
      user_id: user
    )
  end
  let(:food) do
    Food.create(
      name: 'Floor',
      measurement_unit: 'grams',
      price: 5.0,
      user_id: user
    )
  end

  let(:recipe_food) { RecipeFood.new(quantity: 10, recipe_id: recipe, food_id: food) }

  describe 'attributes' do
    it 'Should have a specific quantity' do
      expect(recipe_food.quantity).to eq(10)
    end
    it 'Should have recipe_id equal to the created recipe' do
      expect(recipe_food.recipe_id).to eq(recipe.id)
    end
  end
end

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(name: 'roody', email: 'roody@mail.com') }
  let(:recipe) do
    Recipe.create(
      name: 'Black Rice',
      preparation_time: 0.5,
      cooking_time: 3.5,
      description: 'Recipe Description',
      public: true,
      user_id: user
    )
  end

  describe 'attributes' do
    it 'Should have a name' do
      expect(recipe.name).to eq('Black Rice')
    end

    it 'Should have a preparation time' do
      expect(recipe.preparation_time).to eq(0.5)
    end

    it 'Should have a cooking time' do
      expect(recipe.cooking_time).to eq(3.5)
    end

    it 'Should have a description' do
      expect(recipe.description).to eq('Recipe Description')
    end
  end
end

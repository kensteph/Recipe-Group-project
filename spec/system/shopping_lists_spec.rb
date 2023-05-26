require 'rails_helper'

RSpec.describe 'Shopping list', type: :system do
  describe 'GET /show' do
    let(:tom) do
      User.create!(name: 'Tom', password: '123456', email: 'aaa@a.com')
    end

    let(:food1) do
      Food.create!(name: 'Apple', measurement_unit: 'kg', price: 2.5)
    end

    let(:food2) do
      Food.create!(name: 'Flour', measurement_unit: 'kg', price: 1.2)
    end

    let(:food3) do
      Food.create!(name: 'Egg', measurement_unit: 'units', price: 0.8)
    end

    let(:recipe1) do
      Recipe.create!(name: 'Pie',
                     preparation_time: 1,
                     cooking_time: 1,
                     description: 'Mix all ingredients',
                     user_id: tom.id,
                     public: true)
    end

    let(:r_foods1) do
      RecipeFood.create!(quantity: 1,
                         recipe_id: recipe1.id,
                         food_id: food1.id)
    end

    let(:r_foods2) do
      RecipeFood.create!(quantity: 2,
                         recipe_id: recipe1.id,
                         food_id: food2.id)
    end

    let(:r_foods3) do
      RecipeFood.create!(quantity: 3,
                         recipe_id: recipe1.id,
                         food_id: food3.id)
    end

    let(:inventory1) do
      Inventory.create!(name: 'Inventory 1',
                        description: 'First inventory',
                        user_id: tom.id)
    end

    let(:i_f5) do
      InventoryFood.create!(quantity: 3,
                            inventory_id: inventory1.id,
                            food_id: food1.id)
    end

    let(:i_f6) do
      InventoryFood.create!(quantity: 1,
                            inventory_id: inventory1.id,
                            food_id: food2.id)
    end

    let(:i_f7) do
      InventoryFood.create!(quantity: 1,
                            inventory_id: inventory1.id,
                            food_id: food3.id)
    end

    before(:each) do
      tom.save
      food1.save
      food2.save
      food3.save
      recipe1.save
      r_foods1.save
      r_foods2.save
      r_foods3.save
      inventory1.save
      i_f5.save
      i_f6.save
      i_f7.save
    end
    it 'Should display correctly the title: Shopping List' do
      visit "/shopping_list/#{recipe1.id}/inventory/invent_id?invent_id=#{inventory1.id}&commit=Generate"
      expect(page).to have_content('Shopping List')
    end

    it "Should render the recipe's name" do
      visit "/shopping_list/#{recipe1.id}/inventory/invent_id?invent_id=#{inventory1.id}&commit=Generate"
      expect(page).to have_content(recipe1.name)
    end

    it "Should render the inventory's name" do
      visit "/shopping_list/#{recipe1.id}/inventory/invent_id?invent_id=#{inventory1.id}&commit=Generate"
      expect(page).to have_content(inventory1.name)
    end
  end
end

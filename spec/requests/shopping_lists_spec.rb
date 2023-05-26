require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
  describe 'GET /show' do
    before do
      @tom=User.create(name:'Tom', email:'aaa@a.com')
      @food1 = Food.create(name:'Apple', measurement_unit:'kg', price: 2.5)
      @food2 = Food.create(name:'Flour', measurement_unit:'kg', price: 1.2)
      @food3 = Food.create(name:'Egg', measurement_unit:'units', price: 0.8)
      @recipe1 = Recipe.new(name:'Pie', preparation_time:1, cooking_time:1, description: 'Mix all ingredients', user_id:@tom.id, public:true)
      @r_foods1 = RecipeFood.create(quantity:1, recipe_id:@recipe1.id, food_id:@food1.id)
      @r_foods2 = RecipeFood.create(quantity:2, recipe_id:@recipe1.id, food_id:@food2.id)
      @r_foods3 = RecipeFood.create(quantity:3, recipe_id:@recipe1.id, food_id:@food3.id)
      @inventory1 = Inventory.create(name:'Inventory 1', description:'First inventory', user_id:@tom.id)
      @i_f_5 = InventoryFood.create(quantity: 3, inventory_id: @inventory1.id, food_id: @food1.id)
      @i_f_6 = InventoryFood.create(quantity: 1, inventory_id: @inventory1.id, food_id: @food2.id)
      @i_f_7 = InventoryFood.create(quantity: 1, inventory_id: @inventory1.id, food_id: @food3.id)
    end
    it 'renders show template' do      
      get "/shopping_list/#{@recipe1.id}/inventory/#{@inventory1.id}"
      expect(response).to render_template(:shopping)
    end

    it 'renders a successful response' do
      get "/shopping_list/#{@recipe1.id}/inventory/#{@inventory1.id}"
      expect(response).to be_successful
    end

    it 'Test if is loading correctly the body' do      
      get "/shopping_list/#{@recipe1.id}/inventory/#{@inventory1.id}"
      expect(response.body).to include('Total value of food needed:')
    end
  end
end

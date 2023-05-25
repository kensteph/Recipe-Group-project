class FoodsController < ApplicationController
  # GET /foods or /foods.json
  def index
    @foods = Food.all
  end

  # GET /foods/1 or /foods/1.json
  def show; end

  # GET /foods/new
  def new
    @inventory = Inventory.find(params[:inventory_id])
    @food = Food.new
  end

  # POST /foods or /foods.json
  def create
    @inventory = Inventory.find(params[:inventory_id])
    @food = Food.new(food_params)
    @inventory_food = InventoryFood.new
    @inventory_food.food = @food
    @inventory_food.inventory = @inventory
    @inventory_food.quantity = params[:quantity]

    respond_to do |format|
      if @food.save
        if @inventory_food.save
          format.html do
            redirect_to new_inventory_food_inventory_food_path(@inventory, @food),
                        notice: 'Food was successfully created.'
          end
        else
          format.html { render :new, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to inventory_path(params[:inventory_id]), notice: 'Food was successfully destroyed.' }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end

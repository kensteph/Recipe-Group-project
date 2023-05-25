class InventoryFoodsController < ApplicationController

  # POST /inventory_foods or /inventory_foods.json
  def create
    puts "PARAMS : #{params}"
    @inventory_food = InventoryFood.new(inventory_id: params[:inventory_id], food_id: params[:food_id],quantity: params[:quantity])
    respond_to do |format|
      if @inventory_food.save
          redirect_to inventory_url(params[:inventory_id]), notice: 'Inventory food was successfully created.'
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  private

  # Only allow a list of trusted parameters through.
  def inventory_food_params
    params.require(:inventory_food).permit(:quantity, :inventory_id, :food_id)
  end
end

class InventoryFoodsController < ApplicationController
  load_and_authorize_resource

  def create
    @inventory_food = InventoryFood.new(inventory_id: params[:inventory_id], food_id: params[:food_id],
                                        quantity: params[:quantity])
    respond_to do |format|
      if @inventory_food.save
        redirect_to inventory_url(params[:inventory_id]), notice: 'Inventory food was successfully created.'
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory_food = InventoryFood.find_by(id: params[:id])
    @inventory_food.destroy
    respond_to do |format|
      format.html { redirect_to inventory_url(params[:inventory_id]), notice: 'Food was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def inventory_food_params
    params.require(:inventory_food).permit(:quantity, :inventory_id, :food_id)
  end
end

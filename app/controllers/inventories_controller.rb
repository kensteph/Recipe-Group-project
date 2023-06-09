class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[show edit update destroy]

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.all
  end

  # GET /inventories/1 or /inventories/1.json
  def show
    @foods = Food.all
    @inventory_food = InventoryFood.includes(:food).where(inventory_id: params[:id])
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # POST /inventories or /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.user = current_user
    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_url(@inventory), notice: 'Inventory was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory.destroy
    respond_to do |format|
      format.html { redirect_to inventories_url, notice: 'Inventory was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_inventory
    @inventory = Inventory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end

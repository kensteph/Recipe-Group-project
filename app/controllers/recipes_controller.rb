class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all.order(created_at: :desc)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @inventories = Inventory.all
    @inventories_names = @inventories.pluck(:name)
    @current_user = current_user
    @recipe_foods = RecipeFood.where(recipe_id: params[:id])
    # @foods= []
    # @recipe_foods.each do |item|
    #  @foods << Food.find(item.food_id)
    # end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe) }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  # To handle checkbox
  def checkbox
    @current_user = current_user
    set_recipe
    @recipe.public = !@recipe.public
    @recipe.save
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.json { head :no_content }
    end
  end

  def shopping
    @inventory = Inventory.find(params[:invent_id])
    @recipe = Recipe.find(params[:recipe_id])
    @inventory_foods = InventoryFood.where(inventory_id: params[:invent_id])
    @recipe_foods = RecipeFood.where(recipe_id: params[:recipe_id])
    @inventory_foods_ids = @inventory_foods.pluck(:food_id)
    @amount = 0
    @total_price = 0
    @recipe_foods.includes(:food).each do |item|
      if @inventory_foods_ids.include?(item.food_id)
        @inventory_foods.includes(:food).each do |inventory|
          if item.food_id == inventory.food_id && item.quantity > inventory.quantity
            @total_price += item.food.price * (item.quantity - inventory.quantity)
            @amount += 1
          end
        end
      else
        @total_price += item.food.price * item.quantity
        @amount += 1
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end

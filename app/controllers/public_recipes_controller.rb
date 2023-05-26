class PublicRecipesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @recipes = Recipe.where(public: true).order(created_at: :desc)
    @recipe_foods = RecipeFood.where(recipe_id: params[:id])
  end
end

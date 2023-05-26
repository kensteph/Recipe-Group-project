class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: true)
    @recipe_foods = RecipeFood.where(recipe_id: params[:id])
  end
end

class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: true).order(created_at: :desc)
    @recipe_foods = RecipeFood.where(recipe_id: params[:id])
  end
end

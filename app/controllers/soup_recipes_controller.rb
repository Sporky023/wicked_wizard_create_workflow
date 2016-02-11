class SoupRecipesController < ApplicationController
  def show
    @recipe = SoupRecipe.find(params[:id])
  end
end

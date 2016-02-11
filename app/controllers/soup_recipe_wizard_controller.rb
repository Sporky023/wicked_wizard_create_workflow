class SoupRecipeWizardController < ApplicationController
  include Wicked::Wizard

  steps :veggies, :broth, :spices

  def show
    @recipe = SoupRecipe.new(session[:wizard_recipe_attibutes])

    render_wizard
  end

  def update
    @recipe = SoupRecipe.new( session[:wizard_recipe_attributes] )
    @recipe.assign_attributes(recipe_params)

    if recipe_valid_for_this_step?
      if step == :spices
        @recipe.save!
        session.delete(:wizard_recipe_attributes)

      else
        session[:wizard_recipe_attributes] = @recipe
      end

      redirect_to url_after_update

    else
      render_step step # re-render the same form we just saw
    end
  end

  private

  def url_after_update
    if step == :spices && @recipe.persisted?
      soup_recipe_url(@recipe)
    else
      next_wizard_path
    end
  end

  def recipe_params
    params.require(:soup_recipe).permit(
      :veggie_1, :veggie_2, :veggie_3, :broth, :spice_1, :spice_2, :spice_3
    )
  end

  def recipe_valid_for_this_step?
    @recipe.valid? # calling not for true/false, but to populate @recipe.errors

    attributes_necessary_for(step).each do |attr_name|
      return false if @recipe.errors[attr_name].any?
    end

    true
  end

  def attributes_necessary_for(step)
    {
      :veggies => [:veggie_1, :veggie_2],
      :broth => [:broth],
      :spices => [:spice_1, :spice_2, :spice_3]
    }[step]
  end

  def finish_wizard_path
    soup_recipe_path(@recipe)
  end
end

class SoupRecipe < ActiveRecord::Base
  validates_presence_of(
    :veggie_1, :veggie_2, :broth, :spice_1, :spice_2, :spice_3
  )
end

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    
    @recipe = Recipe.new(name: "chicken barn", summary:"best chicken ever",
      description: "add oil, salt, cook for 20 minutes")
    
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?  
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name length not too long" do
    @recipe.name = "a"*101
    assert_not @recipe.valid?
  end
  
  test "name length not too short" do
    @recipe.name = "a"*4
    assert_not @recipe.valid?
  end
  
 
end
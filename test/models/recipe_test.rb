require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(name: "Bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "chicken barn", summary:"best chicken ever",
      description: "add oil, salt, cook for 20 minutes")
    
  end
  
  test "recipe should be valid" do
    assert @recipe.valid?  
  end
  
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name length not too long" do
    @recipe.name = "a"*101
    assert_not @recipe.valid?
  end
  

 
end
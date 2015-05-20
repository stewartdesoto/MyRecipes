class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end
  
  def show
    #binding.pry    
    @recipe = Recipe.find(params[:id])
  end
  
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(1)
    
    if @recipe.save
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      #flash[:error] = "Your recipe failed miserably"
      render new_recipe_path
    end
  end
  
  def edit
    #binding.pry
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully."
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
    #binding.pry
  end
  
  
  
  
  private
    def recipe_params
      params.require(:recipe).permit(:name,:summary,:description)
    end
end

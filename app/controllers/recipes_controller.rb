class RecipesController < ApplicationController

  def index
    #@recipes = Recipe.all.sort_by{|recipe| recipe.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
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
  
  def like
    @recipe = Recipe.find(params[:id])
    like=Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
    if like.valid? 
      flash[:success] = "Your vote was registered"
      redirect_to :back
    else
      flash[:danger] = "You can only vote once"
      redirect_to :back
    end
  end
  
  
  private
    def recipe_params
#      params.require(:recipe).permit(:name,:summary,:description)
      params.require(:recipe).permit(:name,:summary,:description, :picture)
    end
end

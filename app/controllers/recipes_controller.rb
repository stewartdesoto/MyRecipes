class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: :like
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    #@recipes = Recipe.all.sort_by{|recipe| recipe.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end
  
  def show
    #binding.pry    
  end
  
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    
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
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully."
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
    #binding.pry
  end
  
  def like
    like=Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid? 
      flash[:success] = "Your vote was registered"
      redirect_to :back
    else
      flash[:danger] = "You can only vote once"
      redirect_to :back
    end
  end
  
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success]="Recipe deleted"
    redirect_to recipes_path
  end
  
  
  private
    def recipe_params
      params.require(:recipe).permit(:name,:summary,:description, :picture, style_ids: [], ingredient_ids: [])
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    
    def require_same_user
      if current_user != @recipe.chef and !current_user.admin?
        flash[:danger] = "You can only edit your own recipes"
        redirect_to recipes_path
      end
    end
    
    def admin_user
      redirect_to recipes_path unless current_user.admin?
    end
    
      
  def require_user_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform this action"
      redirect_to :back
    end
  end
    

  
end

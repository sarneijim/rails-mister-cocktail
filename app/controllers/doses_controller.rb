class DosesController < ApplicationController
   before_action :set_dose, only: [:show, :update, :destroy]
  def index         # GET /dose
    @cocktail = Cocktail.find(params[:cocktail_id])
    @doses = @cocktail.doses
  end

  def show          # GET /doses/:id
  end

  def new           # GET /doses/new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @ingredients = Ingredient.all
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    #@ingredients = Ingredient.all
    @dose = Dose.new
    @dose.description = dose_params["description"]
    if (dose_params["ingredient_id"].nil? || dose_params["ingredient_id"].empty?)
      render :new
    else
      @dose.ingredient = Ingredient.find(dose_params["ingredient_id"])
      @dose.cocktail = @cocktail
      if @cocktail.doses.exists?(ingredient: @dose.ingredient, cocktail: @cocktail)
        @dose = Dose.where(ingredient: @dose.ingredient, cocktail: @cocktail)[0]
        @dose.description = dose_params["description"]
      end
      if @dose.save
        redirect_to cocktail_path(@cocktail)
      else
        render :new
      end
    end
  end

  def destroy       # DELETE /doses/:id
    @dose.destroy
    # no need for app/views/doses/destroy.html.erb
    redirect_to cocktails_path
  end

  private

  def dose_params
    # *Strong params*: You need to *whitelist* what can be updated by the user
    # Never trust user data!
    params.require(:dose).permit(:description, :ingredient_id)
  end

  def set_dose
    @dose = Dose.find(params[:id])
  end
end

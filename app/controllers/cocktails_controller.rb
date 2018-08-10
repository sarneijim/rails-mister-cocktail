class CocktailsController < ApplicationController
   before_action :set_cocktail, only: [:show, :update, :destroy]
  def index         # GET /cocktail
    @cocktails = Cocktail.all
  end

  def show          # GET /cocktails/:id
  end

  def new           # GET /cocktails/new
    @cocktail = Cocktail.new
  end

  def create        # POST /cocktails
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end

  end

  def update        # PATCH /cocktails/:id
    @cocktail.update(cocktail_params)

    redirect_to cocktails_path
  end

  def destroy       # DELETE /cocktails/:id
    @cocktail.destroy

    # no need for app/views/cocktails/destroy.html.erb
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    # *Strong params*: You need to *whitelist* what can be updated by the user
    # Never trust user data!
    params.require(:cocktail).permit(:name)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end

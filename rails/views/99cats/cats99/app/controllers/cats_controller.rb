class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    
    render :show
  end

  def new
    @cat = Cat.new(cat_params)
    render :new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    render :edit
  end

  private
  def cat_params
    unless params[:cat]
      return
    end
    params.require(:cat).permit(:birth_date, :color, :name, :sex, :description)
  end
end
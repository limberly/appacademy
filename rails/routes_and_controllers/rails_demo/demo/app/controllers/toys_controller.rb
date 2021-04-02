class ToysController < ApplicationController
  def index
    cat = Cat.find(params[:cat_id])
    render json: cat.toys
  end

  def show
    render json: Toy.find(params[:id])
  end

  def create
    @toy = Toy.new(params[:toy].permit(:cat_id, :name, :ttype))
    @cat = @toy.cat
    if @toy.save
      
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def destroy
    toy = Toy.find(params[:id])
    toy.destroy
    render json: toy
  end

  def update
    toy = Toy.find(params[:id])

    if toy.update(params[:toy].permit(:cat_id, :name, :ttype))
      render json: toy
    else
      render json: toy.errors.full_messages, status: :unprocessable_entity
    end
  end

  def new
    @cat = Cat.find(params[:cat_id])
    @toy = Toy.new
    render :new
  end
end
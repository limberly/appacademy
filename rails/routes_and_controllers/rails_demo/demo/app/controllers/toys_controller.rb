class ToysController < ApplicationController
  def index
    render json: Toy.all
  end

  def show
    render json: Toy.find(params[:id])
  end

  def create
    toy = Toy.new(params[:toy].permit(:cat_id, :name, :ttype))

    if toy.save
      render json: toy
    else
      render json: toy.errors.full_messages, status: :unprocessable_entity
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
end
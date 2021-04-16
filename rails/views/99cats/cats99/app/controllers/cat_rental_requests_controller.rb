class CatRentalRequestsController < ApplicationController
  def new
    @rental = CatRentalRequest.new
    render :new
  end

  def create
    @rental = CatRentalRequest.new(cat_rental_request_params)
    @rental.save!
    redirect_to cat_url(params[:cat_rental_request][:cat_id])
  end

  def approve!
    request = CatRentalRequest.find_by(id: params[:cat_rental_request][:id])
    request.approve!
    redirect_to cat_url(request.cat.id)
  end

  def deny!
    request = CatRentalRequest.find_by(id: params[:cat_rental_request][:id])
    request.deny!
    redirect_to cat_url(request.cat.id)
  end



  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
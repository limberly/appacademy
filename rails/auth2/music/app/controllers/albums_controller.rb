class AlbumsController < ApplicationController
  before_action :require_current_user!
  def new
    @bands = Band.all
    @band = Band.find_by(id: params[:band_id])
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    @band = Band.find_by(name: params[:album][:band_name])
    @album.band_id = @band.id

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:error] = @album.errors.full_messages
      @bands = Band.all
      render :new
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    @tracks = @album.tracks.order(ord: :asc)
    render :show
  end

  def edit
    @album = Album.find_by(id: params[:id])
    @bands = Band.all
    @band = @album.band
    render :edit
  end

  def update
    @album = Album.find_by(id: params[:id])
    @band = Band.find_by(name: params[:album][:band_name])
    @album.band_id = @band.id

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:error] = @album.errors.full_messages
      @bands = Band.all
      render :edit
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end

  private
  def album_params
    params.require(:album).permit(:title, :year, :album_type, :band_id)
  end
end

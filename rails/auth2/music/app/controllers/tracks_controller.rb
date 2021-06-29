class TracksController < ApplicationController
  before_action :require_current_user!

  def new
    @album = Album.find_by(id: params[:album_id])
    @albums = Album.where(band_id: @album.band_id)
    @track = Track.new

    render :new
  end

  def create
    
    @track = Track.new(track_params)
    @album = Album.find_by(title: params[:track][:album_name])
    
    @track.album_id = @album.id
    if @track.save
      redirect_to album_url(@track.album_id)
    else
      flash.now[:error] = @track.errors.full_messages
      @albums = Album.where(band_id: @album.band_id)
      render :new
    end
  end

  def show
    @track = Track.find_by(id: params[:id])
    @notes = Note.select("notes.id, notes.content, users.email").joins(:track, :user).where(track_id: @track.id).order(:created_at)
    render :show
  end

  def edit
    @track = Track.find_by(id: params[:id])
    @albums = Album.all
    @album = Album.find_by(id: @track.album_id)
    render :edit
  end

  def update
    @track = Track.find_by(id: params[:id])
    if @track.update(track_params)
      redirect_to album_url(@track.album_id)
    else
      flash.now[:error] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    @track.destroy
    redirect_to album_url(@track.album_id)
  end

  private
  def track_params
    params.require(:track).permit(:title, :ord, :lyrics, :track_type)
  end
end

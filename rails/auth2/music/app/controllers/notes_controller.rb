class NotesController < ApplicationController
  before_action :require_current_user!

  def show
    
  end

  def new
    @note = Note.new
    @track_id = params[:track_id]
    render :new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    @note.save
    redirect_to track_url(@note.track_id)
  end

  def edit
    @note = Note.find_by(id: params[:id])
    render :edit
  end

  def update
    @note = Note.find_by(id: params[:id])
    @note.update(content: params[:note][:content])
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if current_user.id == @note.user_id
      @note.destroy
    else
      render text: "403 FORBIDDEN"
    end

    redirect_to track_url(@note.track_id)
  end
  
  private
  def note_params
    params.require(:note).permit(:content, :track_id, :user_id)
  end

end

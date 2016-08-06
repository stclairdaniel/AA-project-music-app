class NotesController < ApplicationController
  before_action :require_login
  before_action :require_author, only: [:destroy]

  def create
    @note = Note.new(note_params)
    @track = Track.find_by(id: params[:track_id])
    @note.track_id = params[:track_id]
    @note.user_id = current_user.id
    if @note.save
      flash[:notices] = ["Note saved"]
      redirect_to track_url(params[:track_id])
    else
      flash[:errors] = [@note.errors.full_messages]
      redirect_to track_url(params[:track_id])
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    @note.destroy
    redirect_to track_url(params[:track_id])
  end

  private
  def note_params
    params.require(:note).permit(:content)
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["Must be logged in to post a note"]
      redirect_to track_url(params[:track_id])
    end
  end

  def require_author
    @note = Note.find_by(id: params[:id])
    unless @note.user_id == current_user.id
      flash[:errors] = ["Must be note author to delete note"]
      redirect_to track_url(params[:track_id])
    end
  end
end

class TracksController < ApplicationController
  before_action :require_login

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:notices] = ["Track saved"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = [@track.errors.full_messages]
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      flash[:notices] = ["Track saved"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = [@track.errors.full_messages]
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])
    album_id = @track.album_id
    @track.destroy
    flash[:notices] = ["Track deleted"]
    redirect_to album_url(album_id)
  end

  def show
    @track = Track.find_by(id: params[:id])
    if @track
      render :show
    else
      flash[:errors] = ["Can't find the track you're looking for"]
      redirect_to bands_url
    end
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["Must be logged in to access that content."]
      redirect_to new_session_url
    end
  end
end

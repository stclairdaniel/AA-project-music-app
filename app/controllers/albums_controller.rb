class AlbumsController < ApplicationController
  before_action :require_login

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notices] = ["Album saved"]
      redirect_to album_url(@album)
    else
      flash[:errors] = [@album.errors.full_messages]
      render :new
    end
  end

  def show
    @album = Album.find_by(id: params[:id])
    if @album
      render :show
    else
      flash[:errors] = ["Can't find the album you're looking for"]
      redirect_to bands_url
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      flash[:notices] = ["Album saved"]
      redirect_to album_url(@album)
    else
      flash.now[:errors] = [@album.errors.full_messages]
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    flash[:notices] = ["Album deleted"]
    redirect_to bands_url
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id, :recording_type)
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["Must be logged in to access that content."]
      redirect_to new_session_url
    end
  end
end
